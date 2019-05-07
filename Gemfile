source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'rails', '~> 5.2'
gem 'sass-rails', '~> 5.0.5'
gem 'uglifier', '4.1.20'
gem 'spring', group: :development
gem 'slimmer', '~> 13.1.0'
gem 'plek', '2.1.1'
gem "govuk_app_config", "~> 1.16.0"
gem 'govuk_frontend_toolkit', '8.1.0'
gem 'gds-api-adapters'
gem 'asset_bom_removal-rails', '~> 1.0.0'
gem 'govuk_publishing_components', '~> 16.14.1'

group :development, :test do
  gem 'rspec-rails', '3.8.2'
  gem 'govuk-lint'
  gem 'ci_reporter_rspec'
end

group :test do
  gem 'capybara', '3.18.0'
  gem 'webmock', '~> 3.5.1'
  gem 'rspec-its', '1.3.0'
  gem 'govuk_schemas', '~> 3'
end
