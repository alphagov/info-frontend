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
  end
end
