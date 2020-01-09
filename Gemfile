source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "asset_bom_removal-rails", "~> 1.0.0"
gem "gds-api-adapters"
gem "govuk_app_config", "~> 2.0.1"
gem "govuk_publishing_components", "~> 21.19.0"
gem "plek", "3.0.0"
gem "rails", "~> 5.2"
gem "sass-rails", "~> 5.0.5"
gem "slimmer", "~> 13.2.0"
gem "spring", group: :development
gem "uglifier", "4.2.0"

group :development, :test do
  gem "ci_reporter_rspec"
  gem "rspec-rails", "3.9.0"
  gem "rubocop-govuk"
end

group :test do
  gem "capybara", "3.30.0"
  gem "govuk_schemas", "~> 4"
  gem "rspec-its", "1.3.0"
  gem "webmock", "~> 3.7.6"
end
