namespace :router do
  desc "Register frontend application and routes with the router"
  task :register do
    require 'plek'
    require 'gds_api/router'

    app_id = 'info-frontend'

    @router_api = GdsApi::Router.new(Plek.current.find('router-api'))

    @router_api.add_backend(app_id, Plek.current.find(app_id, force_http: true) + "/")
    @router_api.add_route('/info', 'prefix', app_id)
    @router_api.commit_routes
  end
end
