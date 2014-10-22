require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
#require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InfoFrontend
  class Application < Rails::Application
    config.assets.prefix = "/info-frontend"
  end

  module FeatureFlags
    mattr_accessor :needs_to_show
    mattr_accessor :validated_need_ids
  end
end
