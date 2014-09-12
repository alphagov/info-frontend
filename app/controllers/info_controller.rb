require 'govuk/client/metadata_api'

class InfoController < ApplicationController
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
