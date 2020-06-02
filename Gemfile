source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "asset_bom_removal-rails", "~> 1.0.0"
gem "gds-api-adapters"
gem "govuk_app_config", "~> 2.2.0"
gem "govuk_publishing_components", "~> 21.54.0"
gem "plek", "3.0.0"
gem "rails", "~> 6.0.3"
gem "sass-rails", "~> 5.0.5"
gem "slimmer", "~> 14.0.0"
gem "spring", group: :development
gem "uglifier", "4.2.0"

group :development, :test do
  gem "ci_reporter_rspec"
  gem "rspec-rails", "4.0.1"
  gem "rubocop-govuk"
end

group :test do
  gem "capybara", "3.32.2"
  gem "govuk_schemas", "~> 4"
  gem "rspec-its", "1.3.0"
  gem "webmock", "~> 3.8.3"
end
