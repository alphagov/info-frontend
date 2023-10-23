source "https://rubygems.org"

ruby "~> 3.2.0"

gem "rails", "7.1.1"

gem "bootsnap", require: false
gem "gds-api-adapters"
gem "govuk_app_config"
gem "govuk_publishing_components"
gem "plek"
gem "sass-rails"
gem "slimmer"
gem "spring", group: :development
gem "sprockets-rails"
gem "uglifier"

group :development, :test do
  gem "ci_reporter_rspec"
  gem "rspec-rails"
  gem "rubocop-govuk"
end

group :test do
  gem "brakeman"
  gem "capybara"
  gem "govuk_schemas"
  gem "rspec-its"
  gem "simplecov"
  gem "webmock"
end
