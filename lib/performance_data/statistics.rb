require "json"
require "gds_api/performance_platform/data_out"
require "performance_data/metrics"

module PerformanceData
  class Statistics
    ALLOWED_DOC_TYPES = %w(smart_answer simple_smart_answer).freeze

    attr_accessor :per_page_metrics, :lead_metrics

    def initialize(content, slug)
      @slug = slug
      @content = content
      @per_page_metrics = calculate_per_page_metrics
      @lead_metrics = calculate_lead_metrics
    end

    def data_out
      @data_out ||= GdsApi::PerformancePlatform::DataOut.new("https://www.performance.service.gov.uk")
    end

    def part_urls
      @part_urls ||= get_part_urls(@content, @slug)
    end

    def multipart?
      @multipart ||= @part_urls.any? || ALLOWED_DOC_TYPES.include?(@content["document_type"])
    end

    def searches
      @searches ||= begin
        response = data_out.searches(@slug, multipart?)
        parse_values(response, "searchUniques:sum")
      end
    end

    def page_views
      @page_views ||= begin
        response = data_out.page_views(@slug, multipart?)
        parse_values(response, "uniquePageviews:sum")
      end
    end

    def problem_reports
      @problem_reports ||= begin
        response = data_out.problem_reports(@slug, multipart?)
        parse_values(response, "total:sum")
      end
    end

    # Parses JSON response for the search-terms API call
    #
    # A response example would look like this:
    #
    # data = {
    #     "data": [
    #         {
    #             "_count": 8,
    #             "_group_count": 8,
    #             "searchKeyword": "employer access",
    #             "searchUniques:sum": 100,
    #             "values": [{
    #                            "_count": 1,
    #                            "searchUniques:sum": 126,
    #                            "_end_at": "2014-09-02T00:00:00+00:00",
    #                            "_start_at": "2014-09-01T00:00:00+00:00"
    #                        }]
    #         }
    #     ]
    # }
    #
    # The method would parse that response into:
    # [
    #   {
    #     total_searches: 100,
    #     keyword: "employer access",
    #     searches: [{
    #                 timestamp: "2014-09-01T00:00:00Z",
    #                 value: 126
    #               }]
    #   }
    # ]
    #

    def search_terms
      @search_terms ||= begin
        response = data_out.search_terms(@slug)
        stats = []

        if response.raw_response_body != "null"
          response = response.to_h
          response["data"].map do |item|
            searches = []
            item["values"].each do |value_item|
              searches << {
                  timestamp: value_item["_start_at"].to_datetime,
                  value: value_item["searchUniques:sum"].to_i,
              }
            end

            stats << {
                total_searches: item["searchUniques:sum"].to_i,
                keyword: item["searchKeyword"],
                searches: searches,
            }
          end
        end

        stats
      end
    end

  private

    def calculate_per_page_metrics
      per_page_metrics = {}

      part_urls.each do |path|
        per_page_metrics[path] = per_page_metrics_for(path)
      end

      per_page_metrics
    end

    def calculate_lead_metrics
      pageview_data = performance_data_for(page_views, part_urls)
      search_data = performance_data_for(searches, part_urls)
      problem_data = performance_data_for(problem_reports, part_urls)
      search_term_data = performance_data_for(search_terms, [])

      if multipart?
        PerformanceData::MultiPartMetrics.new(
          unique_pageviews: pageview_data,
          exits_via_search: search_data,
          problem_reports: problem_data,
          search_terms: search_term_data,
        )
      else
        PerformanceData::Metrics.new(
          unique_pageviews: pageview_data,
          exits_via_search: search_data,
          problem_reports: problem_data,
          search_terms: search_term_data,
        )
      end
    end

    # Parses JSON response from content store before displaying it
    #
    # A response example would look like this:
    #
    # {
    #     "data": [
    #         {
    #             "pagePath": "/apply-uk-visa",
    #             "values": [
    #                 {
    #                     "_count": 1,
    #                     "_end_at": "2014-07-04T00:00:00+00:00",
    #                     "_start_at": "2014-07-03T00:00:00+00:00",
    #                     "uniquePageviews:sum": 25931
    #                 }
    #             ]
    #         }
    #     ]
    # }
    #
    # When you call parse_values(data, "uniquePageviews:sum"),
    # the response data will be parsed into:
    # [
    #   {
    #     value: 25931,
    #     path: "/apply-uk-visa",
    #     timestamp: "2014-07-03T00:00:00Z",
    #   }
    # ]
    #

    def parse_values(response, value_name)
      stats = []
      if response.raw_response_body != "null"
        response = response.to_h
        data = response["data"]
        data.map do |item|
          item["values"].each do |value_item|
            stats << {
              value: value_item[value_name].to_i,
              path: item["pagePath"],
              timestamp: value_item["_start_at"].to_datetime,
            }
          end
        end
      end

      stats
    end

    def get_part_urls(content, slug)
      details = content.fetch("details")
      return [] unless details.key?("parts")

      parts = details.fetch("parts")

      part_urls = parts.map! { |part| "#{slug}/#{part['slug']}" }
      part_urls.unshift(slug)
    end

    # For individual page metrics, we don't include search terms
    # because they cannot be broken down into multiple url parts.
    # In fact the search terms response does not return a `pagePath`,
    # but a `searchKeyword` (e.g. `employer access`)
    #
    # Example response for searches:
    #
    # {
    #     "data": [
    #         {
    #             "pagePath": "/tax-disc",
    #             "values": [
    #                 {
    #                     "_count": 4,
    #                     "_end_at": "2014-09-03T00:00:00+00:00",
    #                     "_start_at": "2014-09-02T00:00:00+00:00",
    #                     "searchUniques:sum": 71
    #                 }
    #             ]
    #         }
    #     ]
    # }
    #
    # Example response for search_terms:
    #
    # {
    #     "data": [
    #         {
    #             "_count": 8,
    #             "_group_count": 8,
    #             "searchKeyword": "employer access",
    #             "searchUniques:sum": 126,
    #             "values": [{
    #                            "_count": 1,
    #                            "searchUniques:sum": 126,
    #                            "_end_at": "2014-09-03T00:00:00+00:00",
    #                            "_start_at": "2014-09-02T00:00:00+00:00"
    #                        }]
    #         }
    #     ]
    # }

    def per_page_metrics_for(path)
      PerformanceData::Metrics.new(
        unique_pageviews: performance_data_for(page_views, [path]),
        exits_via_search: performance_data_for(searches, [path]),
        problem_reports: performance_data_for(problem_reports, [path]),
      )
    end

    def performance_data_for(data, part_urls)
      part_urls.empty? ? data : data.select { |record| part_urls.include? record[:path] }
    end
  end
end
