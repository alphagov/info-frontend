require 'govuk/client/metadata_api'

class InfoController < ApplicationController
  def show
    metadata = GOVUK::Client::MetadataAPI.new.info(params[:slug])
    @needs = metadata.fetch("needs")
  end
end
