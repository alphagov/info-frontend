require "rails_helper"
require "govuk/client/test_helpers/metadata_api"

feature "Info page" do
  include GOVUK::Client::TestHelpers::MetadataAPI

  scenario "Understanding the needs of a page" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("User needs")
    expect(page).to have_text("Apply for a UK visa")

    expect(page).to have_text("As a non-EEA national")
    expect(page).to have_text("I need to apply for a UK visa")
    expect(page).to have_text("So that I can come to the UK to visit, study or work")

    # justification for need
    expect(page).to have_text("It's something only government does")

    # need acceptance criteria
    expect(page).to have_text("Finds out how whether they're eligible")
    expect(page).to have_text("How to apply")
    expect(page).to have_text("What documents to provide")

    expect(page.response_headers["Cache-Control"]).to eq("max-age=1800, public")
  end

  scenario "Seeing how many visits are made to a page" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("25k unique pageviews per day")
  end

  scenario "Seeing metrics for multi-part formats" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_multipart_artefact)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Accurate metrics for multi-part formats aren't available yet.")
  end

  scenario "Seeing how many users are leaving via the site search" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("20 searches from the page")
  end

  scenario "Seeing what terms users are searching for" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("login (180)")
    expect(page).to have_text("spouse visa (100)")
  end

  scenario "Seeing where there aren't any recorded user needs" do
    stub_metadata_api_has_slug('some-slug', metadata_api_response_with_no_needs)

    visit "/info/some-slug"

    expect(page).to have_text("There aren't any recorded needs for this page.")
  end

  scenario "When there isn't any performance data available" do
    stub_metadata_api_has_slug('some-slug', metadata_api_response_with_no_performance_data)

    visit "/info/some-slug"

    expect(page).to have_text("0 unique pageviews per day")
    expect(page).to have_text("0 searches from the page")
  end

  scenario "When no information is available for a given slug" do
    stub_metadata_api_has_no_data_for_slug('slug-without-info')

    visit "/info/slug-without-info"

    expect(page.status_code).to eq(404)
  end

  context "configuring whether or not to show the user need" do
    after(:each) do
      InfoFrontend::FeatureFlags.show_needs = true
    end

    scenario "shows the user need by default" do
      stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

      visit "/info/apply-uk-visa"

      expect(page).to have_text("User needs and metrics")
      expect(page).to have_text("non-EEA national")
      expect(page).to have_text("apply for a UK visa")
      expect(page).to have_text("I can come to the UK to visit, study or work")
    end

    scenario "doesn't show the user need if set to false" do
      InfoFrontend::FeatureFlags.show_needs = false

      stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

      visit "/info/apply-uk-visa"

      expect(page).to_not have_text("User needs and metrics")
      expect(page).to_not have_text("non-EEA national")
      expect(page).to_not have_text("apply for a UK visa")
      expect(page).to_not have_text("I can come to the UK to visit, study or work")

      expect(page).to have_text("Metrics")
    end
  end
end
