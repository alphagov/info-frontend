require 'uri'
require 'govuk/client/metadata_api'
require 'performance_data/metrics'

class InfoController < ApplicationController
  before_filter :set_expiry, only: :show

  def show
    @slug = URI.encode(params[:slug])
    metadata = GOVUK::Client::MetadataAPI.new.info(@slug)
    if metadata
      @artefact = metadata.fetch("artefact")
      @needs = metadata.fetch("needs")
      if InfoFrontend::FeatureFlags.needs_to_show == :only_validated
        @needs.select! { |need| InfoFrontend::FeatureFlags.validated_need_ids.include?(need["id"]) }
      end
      part_urls = get_part_urls(@artefact, @slug)
      calculated_metrics = metrics_from(@artefact, metadata.fetch("performance"), part_urls)
      @lead_metrics = calculated_metrics[:lead_metrics]
      @per_page_metrics = calculated_metrics[:per_page_metrics]
      @show_needs = [:all, :only_validated].include?(InfoFrontend::FeatureFlags.needs_to_show)

    else
      response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
      head 404
    end
  end

private
  def get_part_urls(artefact, slug)
    details = artefact.fetch("details")
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

  def metrics_from(artefact, performance_data, part_urls = [])
    all_metrics = AllMetrics.new(performance_data, part_urls)
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
  def initialize(performance_data, part_urls)
    @performance_data = performance_data
    @part_urls = part_urls
  end

  def lead_metrics
    PerformanceData::Metrics.new(
      unique_pageviews: performance_data_for("page_views", @part_urls).map {|l| l["value"] },
      exits_via_search: performance_data_for("searches", @part_urls).map {|l| l["value"] },
      problem_reports: performance_data_for("problem_reports", @part_urls).map {|l| l["value"] },
      search_terms: performance_data_for("search_terms", @part_urls).map {|term| { keyword: term["Keyword"], total: term["TotalSearches"] } },
    )
  end

  def metrics_for(path)
    PerformanceData::Metrics.new(
      unique_pageviews: performance_data_for("page_views", [path]).map {|l| l["value"] },
      exits_via_search: performance_data_for("searches", [path]).map {|l| l["value"] },
      problem_reports: performance_data_for("problem_reports", [path]).map {|l| l["value"] },
    )
  end

  def performance_data_for(metric, part_urls)
    data = @performance_data[metric] || []
    part_urls.empty? ? data : data.select { |record| part_urls.include? record["path"] }
  end
end
