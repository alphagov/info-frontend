require "rails_helper"
require "ostruct"

RSpec.describe "info/lead_metrics" do
  let(:defaults) { { unique_pageviews_average: 0, exits_via_search_average: 0 } }
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
end
