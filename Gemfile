source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "rails", "6.0.3.2"

gem "asset_bom_removal-rails"
gem "gds-api-adapters"
gem "govuk_app_config"
gem "govuk_publishing_components"
gem "plek"
gem "sass-rails"
gem "slimmer"
gem "spring", group: :development
gem "uglifier"

group :development, :test do
  gem "ci_reporter_rspec"
  gem "rspec-rails"
  gem "rubocop-govuk"
end

group :test do
  gem "capybara"
  gem "govuk_schemas"
  gem "rspec-its"
  gem "webmock"
end
