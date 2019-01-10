require 'uri'
require 'performance_data/statistics'
require 'performance_data/metrics'

class InfoController < ApplicationController
  include GdsApi::Helpers
  rescue_from GdsApi::ContentStore::ItemNotFound, with: :not_found
  rescue_from GdsApi::HTTPGone, with: :not_found
  before_action :set_expiry, only: :show

  def show
    @slug = parse_slug
    @content = content_store.content_item(@slug).to_h
    @needs = @content["links"]["meets_user_needs"]
    @statistics = PerformanceData::Statistics.new(@content, @slug)
  end

private

  def parse_slug
    slug = URI.encode(params[:slug]) # rubocop:disable Lint/UriEscapeUnescape
    slug[0] != '/' ? "/#{slug}" : slug
  end

  def not_found
    response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
    head 404
  end
end
