require "uri"

class InfoController < ApplicationController
  rescue_from GdsApi::ContentStore::ItemNotFound, with: :not_found
  rescue_from GdsApi::HTTPGone, with: :not_found
  before_action :set_expiry, only: :show

  def show
    @slug = parse_slug
    @content = GdsApi.content_store.content_item(@slug).to_h
    @needs = @content["links"]["meets_user_needs"]
  end

private

  def parse_slug
    query = params[:slug]
    slug = URI.encode_www_form_component(query).gsub("%2F", "/")
    slug[0] != "/" ? "/#{slug}" : slug
  end

  def not_found
    response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
    head 404
  end
end
