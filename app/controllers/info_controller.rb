require 'govuk/client/metadata_api'
require 'performance_data/lead_metrics'

class InfoController < ApplicationController
  before_filter :set_expiry, only: :show

  def show
    slug = URI.encode(params[:slug])
    metadata = GOVUK::Client::MetadataAPI.new.info(slug)
    if metadata
      @artefact = metadata.fetch("artefact")
      @needs = metadata.fetch("needs")
      if InfoFrontend::FeatureFlags.needs_to_show == :only_validated
        @needs.select! { |need| InfoFrontend::FeatureFlags.validated_need_ids.include?(need["id"]) }
      end
      @lead_metrics = lead_metrics_from(@artefact, metadata.fetch("performance"))
      @show_needs = [:all, :only_validated].include?(InfoFrontend::FeatureFlags.needs_to_show)
    else
      response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
      head 404
    end
  end

private
  def lead_metrics_from(artefact, performance_data)
    if artefact.fetch("details")["parts"]
      return nil # can't present metrics for multi-part content yet
    else
      uniques = (performance_data["page_views"] || []).map {|l| l["value"] }
      searches = (performance_data["searches"] || []).map {|l| l["value"] }
      problem_reports = (performance_data["problem_reports"] || []).map {|l| l["value"] }
      search_terms = (performance_data["search_terms"] || []).map {|term| { keyword: term["Keyword"], total: term["TotalSearches"] } }
      PerformanceData::LeadMetrics.new(
        unique_pageviews: uniques,
        exits_via_search: searches,
        search_terms: search_terms,
        problem_reports: problem_reports,
      )
    end
  end
end
