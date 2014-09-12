require 'plek'

module GOVUK
  module Client
    module TestHelpers
      module MetadataAPI
        METADATA_API_ENDPOINT = Plek.new.find('metadata-api')

        def stub_metadata_api_has_slug(slug, response)
          stub_request(:get, %r[\A#{METADATA_API_ENDPOINT}/info/#{slug}]).
            to_return(status: 200, body: response.to_json, headers: {content_type: "application/json"})
        end

        def stub_metadata_api_has_no_data_for_slug(slug)
          stub_request(:get, %r[\A#{METADATA_API_ENDPOINT}/info/#{slug}]).
            to_return(status: 404, headers: {content_type: "application/json"})
        end
      end
    end
  end
end
