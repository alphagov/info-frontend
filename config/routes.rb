Rails.application.routes.draw do
  get 'info/:slug' => 'info#show', constraints: { slug: /.*/}
end
