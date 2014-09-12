require 'govuk/client/metadata_api'

class InfoController < ApplicationController
  before_filter :set_expiry, only: :show

  def show
    metadata = GOVUK::Client::MetadataAPI.new.info(params[:slug])
    if metadata
      @artefact = metadata.fetch("artefact")
      @needs = metadata.fetch("needs")
    else
      response.headers[Slimmer::Headers::SKIP_HEADER] = "1"
      head 404
    end
  end
end
