source "https://rubygems.org"

gem "rails", "7.0.4"

gem "gds-api-adapters"
gem "govuk_app_config", github: "alphagov/govuk_app_config", branch: "csp-modernisation"
gem "govuk_publishing_components"
gem "mail", "~> 2.7.1"  # TODO: remove once https://github.com/mikel/mail/issues/1489 is fixed.
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
