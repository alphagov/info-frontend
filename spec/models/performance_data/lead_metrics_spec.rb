require "spec_helper"
require "performance_data/metrics"

module PerformanceData
  describe Metrics do
    subject { Metrics.new(data) }

    context "unique pageviews" do
      context "some unique pageviews" do
        let(:data) do
          { unique_pageviews: [
            { value: 3 },
            { value: 2 },
            { value: 1 },
          ] }
        end
        its(:unique_pageviews_average) { should eq(2) }
      end

      context "no unique pageview data" do
        let(:data) { { unique_pageviews: [] } }
        its(:unique_pageviews_average) { should eq(0) }
      end

      context "average unique pageviews less than 1" do
        let(:data) do
          { unique_pageviews: [
            { value: 0 },
            { value: 1 },
          ] }
        end
        its(:unique_pageviews_average) { should eq(0.5) }
      end
    end

    context "users leaving through search" do
      context "some on-page searches" do
        let(:data) do
          { exits_via_search: [
            { value: 3 },
            { value: 2 },
            { value: 1 },
          ] }
        end
        its(:exits_via_search_average) { should eq(2) }
      end
    end

    context "on-page search terms used by users" do
      let(:search_terms) { 1.upto(19).map { |n| { keyword: "some-term-#{n}", total_searches: n } } }
      let(:data) { { search_terms: search_terms } }

      it "shows the most popular 10 search terms that were searched for at least 10 times" do
        10.upto(19).each do |n|
          expect(subject.top_10_search_terms).to include(keyword: "some-term-#{n}", total: n)
        end
        9.downto(1).each do |n|
          expect(subject.top_10_search_terms).not_to include(keyword: "some-term-#{n}", total: n)
        end
      end
    end

    context "problem reports" do
      let(:data) do
        { problem_reports: [
          { value: 1 },
          { value: 3 },
          { value: 3 },
          { value: 0 },
          { value: 0 },
          { value: 0 },
          { value: 0 },
        ] }
      end
      its(:problem_reports_weekly_average) { should eq(7) }
    end
  end

  describe MultiPartMetrics do
    subject { MultiPartMetrics.new(data) }

    context "unique pageviews" do
      context "some unique pageviews" do
        let(:data) do
          { unique_pageviews: [
            {
              value: 3,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
            {
              value: 2,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
            {
              value: 1,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
            {
              value: 1,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
          ] }
        end
        its(:unique_pageviews_average) { should eq(3.5) }
      end

      context "no unique pageview data" do
        let(:data) { { unique_pageviews: [] } }
        its(:unique_pageviews_average) { should eq(0) }
      end

      context "average unique pageviews less than 1" do
        let(:data) do
          { unique_pageviews: [
            {
              value: 0,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
            {
              value: 1,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
            {
              value: 0,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
            {
              value: 0,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
          ] }
        end
        its(:unique_pageviews_average) { should eq(0.5) }
      end
    end

    context "users leaving through search" do
      context "some on-page searches" do
        let(:data) do
          { exits_via_search: [
            {
              value: 2,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
            {
              value: 4,
              timestamp: "2014-11-05T00:00:00+00:00",
            },
            {
              value: 0,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
            {
              value: 1,
              timestamp: "2014-11-06T00:00:00+00:00",
            },
          ] }
        end
        its(:exits_via_search_average) { should eq(3.5) }
      end
    end

    context "on-page search terms used by users" do
      let(:search_terms) { 1.upto(19).map { |n| { keyword: "some-term-#{n}", total_searches: n } } }
      let(:data) { { search_terms: search_terms } }

      it "shows the most popular 10 search terms that were searched for at least 10 times" do
        10.upto(19).each do |n|
          expect(subject.top_10_search_terms).to include(keyword: "some-term-#{n}", total: n)
        end
        9.downto(1).each do |n|
          expect(subject.top_10_search_terms).not_to include(keyword: "some-term-#{n}", total: n)
        end
      end
    end

    context "problem reports" do
      let(:data) do
        { problem_reports: [
          {
            value: 1,
            timestamp: "2014-11-01T00:00:00+00:00",
          },
          {
            value: 3,
            timestamp: "2014-11-02T00:00:00+00:00",
          },
          {
            value: 3,
            timestamp: "2014-11-03T00:00:00+00:00",
          },
          {
            value: 0,
            timestamp: "2014-11-04T00:00:00+00:00",
          },
          {
            value: 0,
            timestamp: "2014-11-05T00:00:00+00:00",
          },
          {
            value: 0,
            timestamp: "2014-11-06T00:00:00+00:00",
          },
          {
            value: 3,
            timestamp: "2014-11-07T00:00:00+00:00",
          },
        ] }
      end
      its(:problem_reports_weekly_average) { should eq(10) }
    end

    context "problem reports with less than a week of data should extrapolate" do
      let(:data) do
        { problem_reports: [
          {
            value: 1,
            timestamp: "2014-11-01T00:00:00+00:00",
          },
          {
            value: 3,
            timestamp: "2014-11-02T00:00:00+00:00",
          },
        ] }
      end
      its(:problem_reports_weekly_average) { should eq(14) }
    end
  end
end
