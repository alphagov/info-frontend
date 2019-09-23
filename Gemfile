source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'rails', '~> 5.2'
gem 'sass-rails', '~> 5.0.5'
gem 'uglifier', '4.1.20'
gem 'spring', group: :development
gem 'slimmer', '~> 13.1.0'
gem 'plek', '3.0.0'
gem "govuk_app_config", "~> 2.0.0"
gem 'gds-api-adapters'
gem 'asset_bom_removal-rails', '~> 1.0.0'
gem 'govuk_publishing_components', '~> 21.1.1'

group :development, :test do
  gem 'rspec-rails', '3.8.2'
  gem 'govuk-lint'
  gem 'ci_reporter_rspec'
end

group :test do
  gem 'capybara', '3.29.0'
  gem 'webmock', '~> 3.7.5'
  gem 'rspec-its', '1.3.0'
  gem 'govuk_schemas', '~> 4'
end
