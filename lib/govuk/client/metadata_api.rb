require "plek"

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
        GdsApi::JsonClient.new.get_json(@base_url.merge("/info/#{slug}").to_s)
      end
    end
  end
end
