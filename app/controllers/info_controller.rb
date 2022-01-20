require "uri"

class InfoController < ApplicationController
  rescue_from GdsApi::ContentStore::ItemNotFound, with: :not_found
  rescue_from GdsApi::HTTPGone, with: :not_found

  def show
    @slug = parse_slug
    @content_item = GdsApi.content_store.content_item(@slug)
    set_expiry
    @content = @content_item.to_h
    @needs = @content["links"]["meets_user_needs"]
  end

private

  def set_expiry
    expires_in(
      @content_item.cache_control.max_age,
      public: !@content_item.cache_control.private?,
    )
  end

  def parse_slug
    query = params[:slug]
    slug = URI.encode_www_form_component(query).gsub("%2F", "/")
    slug[0] != "/" ? "/#{slug}" : slug
  end

  def not_found
    response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
    head :not_found
  end
end
