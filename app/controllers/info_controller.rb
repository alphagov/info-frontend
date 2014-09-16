require 'govuk/client/metadata_api'
require 'performance_data/lead_metrics'

class InfoController < ApplicationController
  before_filter :set_expiry, only: :show

  def show
    metadata = GOVUK::Client::MetadataAPI.new.info(params[:slug])
    if metadata
      @artefact = metadata.fetch("artefact")
      @needs = metadata.fetch("needs")
      @lead_metrics = lead_metrics_from(metadata.fetch("performance").fetch("data"))
    else
      response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
      head 404
    end
  end

private
  def lead_metrics_from(performance_data)
    uniques = performance_data.map {|l| l["uniquePageViews"] }
    PerformanceData::LeadMetrics.new(unique_pageviews: uniques)
  end
end
