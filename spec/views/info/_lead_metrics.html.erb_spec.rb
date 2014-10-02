require "rails_helper"
require "ostruct"

RSpec.describe "info/lead_metrics" do
  let(:defaults) { {
    unique_pageviews_average: 0,
    exits_via_search_average: 0,
    problem_reports_weekly_average: 0,
    top_10_search_terms: []
    }
  }
  let(:locals) { { lead_metrics: OpenStruct.new(defaults.merge(data)) } }

  context "when there's very little traffic" do
    let(:data) { { unique_pageviews_average: 0.5 } }

    it "displays pageviews" do
      render partial: "info/lead_metrics", locals: locals

      expect(rendered).to have_text("< 1 unique pageviews per day")
    end
  end

  context "when there's lots of traffic" do
    let(:data) { { unique_pageviews_average: 12345 } }

    it "displays pageviews in a human readable form" do
      render partial: "info/lead_metrics", locals: locals

      expect(rendered).to have_text("12.3k unique pageviews per day")
    end
  end

  context "when users have searched on the page" do
    let(:data) { { top_10_search_terms: [ { total: 4, keyword: "abc" }, { total: 5, keyword: "xyz" } ] } }

    it "displays search terms" do
      render partial: "info/lead_metrics", locals: locals

      expect(rendered).to have_text("abc (4)")
      expect(rendered).to have_text("xyz (5)")
    end
  end

  context "when users have left problem reports" do
    let(:data) { { problem_reports_weekly_average: 50.2 } }

    it "displays problem reports in a human readable form" do
      render partial: "info/lead_metrics", locals: locals

      expect(rendered).to have_text("50.2 problem reports per week")
    end
  end
end
