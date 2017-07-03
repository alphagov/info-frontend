require 'uri'
require 'gds_api/helpers'
require 'performance_data/statistics'
require 'performance_data/metrics'

class InfoController < ApplicationController
  include GdsApi::Helpers
  rescue_from GdsApi::ContentStore::ItemNotFound, with: :not_found
  rescue_from GdsApi::HTTPGone, with: :not_found
  before_action :set_expiry, only: :show

  def show
    @slug = URI.encode(params[:slug])

    @content = content_store.content_item("/#{@slug}").to_h
    @needs = @content["links"]["meets_user_needs"]

    begin
      statistics = PerformanceData::Statistics.new(@content, @slug)

      @is_multipart = statistics.is_multipart
      @lead_metrics = statistics.lead_metrics
      @per_page_metrics = statistics.per_page_metrics
    rescue StandardError => e
      logger.error "Performance data related error for #{@slug}"
      logger.error e.message
    end
  end

private

  def not_found
    response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
    head 404
  end
end


