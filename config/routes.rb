Rails.application.routes.draw do
  mount GovukPublishingComponents::Engine, at: "/component-guide"
  get "info/:slug" => "info#show", constraints: { slug: /.*/ }

  get "/healthcheck/live", to: proc { [200, {}, %w[OK]] }
  get "/healthcheck/ready", to: GovukHealthcheck.rack_response
end
