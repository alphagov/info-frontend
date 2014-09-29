module InfoFrontend
  module FeatureFlags
    mattr_accessor :show_needs
  end
end

# Show user needs by default.
InfoFrontend::FeatureFlags.show_needs = true
