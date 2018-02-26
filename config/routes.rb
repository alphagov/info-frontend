Rails.application.routes.draw do
  mount GovukPublishingComponents::Engine, at: "/component-guide"
  get 'info/:slug' => 'info#show', constraints: { slug: /.*/}
end
