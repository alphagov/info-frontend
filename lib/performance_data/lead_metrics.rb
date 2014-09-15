module PerformanceData
  class LeadMetrics
    def initialize(data)
      @data = data
    end

    def unique_pageviews_average
      traffic = @data[:unique_pageviews]
      traffic.empty? ? 0 : traffic.inject(0, :+) / traffic.size.to_f
    end
  end
end
