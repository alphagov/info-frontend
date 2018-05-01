Rails.application.routes.draw do
  mount GovukPublishingComponents::Engine, at: "/component-guide"
  get 'info/:slug' => 'info#show', constraints: { slug: /.*/}

  get "/healthcheck", to: GovukHealthcheck.rack_response
end
