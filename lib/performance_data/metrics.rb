module PerformanceData
  class Metrics
    def initialize(data)
      @data = data
    end

    def unique_pageviews_average
      average(@data[:unique_pageviews].map {|l| l["value"] })
    end

    def exits_via_search_average
      average(@data[:exits_via_search].map {|l| l["value"] })
    end

    def problem_reports_weekly_average
      average(@data[:problem_reports].map {|l| l["value"] }) * 7
    end

    def top_10_search_terms
      @data[:search_terms].
        map {|term| { keyword: term["Keyword"], total: term["TotalSearches"] } }.
        reject { |term| term[:total] < 10 }.
        sort_by { |term| -1 * term[:total] }.
        take(10)
    end

  private
    def average(list)
      list.empty? ? 0 : list.inject(0, :+) / list.size.to_f
    end
  end

  class MultiPartMetrics < Metrics

    def unique_pageviews_average
      dataset = @data[:unique_pageviews]
      days = number_of_days(dataset)
      days == 0.0 ? 0.0 : dataset.map {|l| l["value"] }.reduce(:+) / days
    end

    def exits_via_search_average
      dataset = @data[:exits_via_search]
      days = number_of_days(dataset)
      days == 0.0 ? 0.0 : dataset.map {|l| l["value"] }.reduce(:+) / days
    end

    def problem_reports_weekly_average
      dataset = @data[:problem_reports]
      days = number_of_days(dataset)
      weeks = days / 7.0
      days == 0.0 ? 0.0 : dataset.map {|l| l["value"] }.reduce(:+) / weeks
    end

  private
    def number_of_days(dataset)
      dataset.empty? ? 0.0 : dataset.uniq{|l| l["timestamp"]}.length.to_f
    end
  end

end
