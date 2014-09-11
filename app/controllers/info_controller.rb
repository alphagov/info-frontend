require 'govuk/client/metadata_api'

class InfoController < ApplicationController
  def show
    metadata = GOVUK::Client::MetadataAPI.new.info(params[:slug])
    @artefact = metadata.fetch("artefact")
    @needs = metadata.fetch("needs")
  end
end
