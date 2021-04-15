# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start "rails"

require "spec_helper"
require File.expand_path("../config/environment", __dir__)
require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

Rails.application.load_tasks

RSpec.configure(&:infer_spec_type_from_file_location!)
