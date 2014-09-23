require "spec_helper"
require 'performance_data/lead_metrics'

module PerformanceData
  describe LeadMetrics do
    subject { LeadMetrics.new(data) }

    context "unique pageviews" do
      context "some unique pageviews" do
        let(:data) { { unique_pageviews: [3, 2, 1] } }
        its(:unique_pageviews_average) { should eq(2) }
      end

      context "no unique pageview data" do
        let(:data) { { unique_pageviews: [] } }
        its(:unique_pageviews_average) { should eq(0) }
      end

      context "average unique pageviews less than 1" do
        let(:data) { { unique_pageviews: [1, 0] } }
        its(:unique_pageviews_average) { should eq(0.5) }
      end
    end

    context "users leaving through search" do
      context "some on-page searches" do
        let(:data) { { exits_via_search: [3, 2, 1] } }
        its(:exits_via_search_average) { should eq(2) }
      end
    end

    context "on-page search terms used by users" do
      context "10 search terms availables" do
        let(:search_terms) { 1.upto(11).map {|n| { keyword: "some-term-#{n}", total: n } } }
        let(:data) { { search_terms: search_terms } }

        it "shows the most popular 10 search terms" do
          2.upto(11).each do |n|
            expect(subject.top_10_search_terms).to include(keyword: "some-term-#{n}", total: n)
          end
          expect(subject.top_10_search_terms).not_to include(keyword: "some-term-1", total: 1)
        end
      end
    end
  end
end
