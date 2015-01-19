module PerformanceData
  class Metrics
    def initialize(data)
      @data = data
    end

    def unique_pageviews_average
      average(@data[:unique_pageviews])
    end

    def exits_via_search_average
      average(@data[:exits_via_search])
    end

    def problem_reports_weekly_average
      average(@data[:problem_reports]) * 7
    end

    def top_10_search_terms
      @data[:search_terms].
        reject { |term| term[:total] < 10 }.
        sort_by { |term| -1 * term[:total] }.
        take(10)
    end

  private
    def average(list)
      list.empty? ? 0 : list.inject(0, :+) / list.size.to_f
    end
  end
end
