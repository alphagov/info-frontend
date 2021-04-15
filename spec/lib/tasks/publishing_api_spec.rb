require "rails_helper"
require "gds_api/test_helpers/publishing_api"
require "rake"

RSpec.describe "publishing_api.rake" do
  include GdsApi::TestHelpers::PublishingApi

  it "should publish special routes" do
    content_id = "bce40c1f-2259-4404-b275-8c5e04afef34"

    put_content_stub = stub_publishing_api_put_content(content_id, {})
    publish_content_stub = stub_publishing_api_publish(content_id, {})

    Rake.application["publishing_api:publish_special_routes"].invoke

    expect(put_content_stub).to have_been_requested.once
    expect(publish_content_stub).to have_been_requested.once
  end
end
