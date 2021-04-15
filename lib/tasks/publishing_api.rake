require "logger"
require "gds_api/publishing_api"
require "gds_api/publishing_api/special_route_publisher"

namespace :publishing_api do
  desc "Publish special routes via publishing api"
  task publish_special_routes: :environment do
    logger = Logger.new(STDOUT)
    publishing_api = GdsApi::PublishingApi.new(
      Plek.new.find("publishing-api"),
      bearer_token: ENV["PUBLISHING_API_BEARER_TOKEN"] || "example",
    )
    special_route_publisher = GdsApi::PublishingApi::SpecialRoutePublisher.new(
      logger: logger,
      publishing_api: publishing_api,
    )

    special_route_publisher.publish(
      content_id: "bce40c1f-2259-4404-b275-8c5e04afef34",
      title: "Info pages",
      description: "Information including user needs of GOV.UK pages",
      base_path: "/info",
      type: "prefix",
      publishing_app: "info-frontend",
      rendering_app: "info-frontend",
    )
  end
end
