require "govuk/client/response"
require "govuk/client/errors"

require "plek"
require "rest-client"
require "multi_json"

module GOVUK
  module Client
    class MetadataAPI

      # @param base_url [String] the base URL for the service (eg
      #   https://url-arbiter.example.com).  If unspecified, this will be
      #   looked up with {https://github.com/alphagov/plek Plek}.
      def initialize(base_url = nil)
        base_url ||= Plek.new.find('metadata-api')
        @base_url = URI.parse(base_url)
      end

      def info(slug)
        get_json("/info/#{slug}")
      end

    private

      def get_json(path)
        response = RestClient.get(@base_url.merge(path).to_s)
        Response.new(response.code, response.body)
      rescue RestClient::ResourceNotFound, RestClient::Gone
        nil
      rescue RestClient::Exception => e
        raise Errors.create_for(e)
      end
    end
  end
end
