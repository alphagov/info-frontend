module PerformanceData
  class LeadMetrics
    def initialize(data)
      @data = data
    end

    def unique_pageviews_average
      average(@data[:unique_pageviews])
    end

    def exits_via_search_average
      average(@data[:exits_via_search])
    end

  private
    def average(list)
      list.empty? ? 0 : list.inject(0, :+) / list.size.to_f
    end
  end
end
