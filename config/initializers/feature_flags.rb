module InfoFrontend
  module FeatureFlags
    class << self
      attr_accessor :show_needs
    end
  end
end

# Show user needs by default.
InfoFrontend::FeatureFlags.show_needs = true
