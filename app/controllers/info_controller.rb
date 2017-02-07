require 'uri'
require 'gds_api/helpers'
require 'govuk/client/metadata_api'
require 'performance_data/metrics'

class InfoController < ApplicationController
  include GdsApi::Helpers
  before_action :set_expiry, only: :show

  def show
    @slug = URI.encode(params[:slug])

    @content = content_store.content_item("/#{@slug}").try(:to_h)

    if @content
      @needs = @content["links"]["meets_user_needs"]
    end

    begin
      metadata = GOVUK::Client::MetadataAPI.new.info(@slug)
    rescue StandardError
      metadata = nil
    end

    if metadata
      unless @content
        # If the content store does not have this content, fall back
        # to the Metadata API, which may be able to fetch the content
        # from the content-api
        @content = metadata.fetch("artefact")
        valid_needs = metadata.fetch("needs").select do |need|
          need["status"]["description"] == "valid"
        end
        @needs = valid_needs.map { |need| { "details" => need } }
      end

      document_type = @content["document_type"] || @content["format"]

      part_urls = get_part_urls(@content, @slug)
      @is_multipart = is_multipart(part_urls, document_type)
      calculated_metrics = metrics_from(metadata.fetch("performance"), part_urls, @is_multipart)
      @lead_metrics = calculated_metrics[:lead_metrics]
      @per_page_metrics = calculated_metrics[:per_page_metrics]
    end

    unless @content || metadata
      response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
      head 404
    end
  end

private

  def get_part_urls(content, slug)
    details = content.fetch("details")
    part_urls = []
    if details.key?("parts")
      part_urls = details.fetch("parts") || []
      if !part_urls.empty?
        part_urls.map! {|part_url| URI(part_url["web_url"]).path }
        part_urls.unshift(slug.insert(0, "/"))
      end
    end
    return part_urls
  end

  def is_multipart(part_urls, document_type)
    part_urls.any? || (document_type == 'smart-answer')
  end

  def metrics_from(performance_data, part_urls, is_multipart)
    all_metrics = AllMetrics.new(performance_data, part_urls, is_multipart)
    { lead_metrics: all_metrics.lead_metrics }.tap do |metrics|
      metrics[:per_page_metrics] = {}
      part_urls.each do |path|
        metrics[:per_page_metrics][path] = all_metrics.metrics_for(path)
      end
      if metrics[:per_page_metrics] == {}
        metrics[:per_page_metrics] = nil
      end
    end
  end
end

class AllMetrics
  def initialize(performance_data, part_urls, is_multipart)
    @performance_data = performance_data
    @part_urls = part_urls
    @is_multipart = is_multipart
  end

  def lead_metrics
    pageview_data = performance_data_for("page_views", @part_urls)
    search_data = performance_data_for("searches", @part_urls)
    problem_data = performance_data_for("problem_reports", @part_urls)
    search_term_data = performance_data_for("search_terms", [])
    if @is_multipart
      return PerformanceData::MultiPartMetrics.new(
        unique_pageviews: pageview_data,
        exits_via_search: search_data,
        problem_reports: problem_data,
        search_terms: search_term_data
      )
    else
      return PerformanceData::Metrics.new(
        unique_pageviews: pageview_data,
        exits_via_search: search_data,
        problem_reports: problem_data,
        search_terms: search_term_data
      )
    end
  end

  def metrics_for(path)
    PerformanceData::Metrics.new(
      unique_pageviews: performance_data_for("page_views", [path]),
      exits_via_search: performance_data_for("searches", [path]),
      problem_reports: performance_data_for("problem_reports", [path]),
    )
  end

  def performance_data_for(metric, part_urls)
    data = @performance_data[metric] || []
    part_urls.empty? ? data : data.select { |record| part_urls.include? record["path"] }
  end
end
