require 'slimmer/test'
require 'slimmer/test_helpers/govuk_components'

RSpec.configure do |c|
  c.include Slimmer::TestHelpers::GovukComponents, type: :feature
  c.before(:each, type: :feature) do
    stub_shared_component_locales
  end
end
