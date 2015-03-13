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

    expect(page.response_headers["Cache-Control"]).to eq("max-age=43200, public")
  end

  scenario "Seeing how many visits are made to a page" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Unique pageviews 25k per day")
  end

  scenario "Seeing response for a smart answer" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_smart_answer)

    visit "/info/apply-uk-visa"

    # Check a smart answer is treated as a multipart format
    expect(page).to have_text("Metrics across all pages")
  end

  scenario "Seeing metrics for multi-part formats" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_multipart_artefact)

    visit "/info/apply-uk-visa"

    within("#lead-metrics") do
      # check lead metrics for multipart formats are summed
      # across all pages in the format
      expect(page).to have_text("Unique pageviews 67.7k per day")
      expect(page).to have_text("Searches started 19.4k per day")
      expect(page).to have_text("Problem reports 41 per week")
      expect(page).to have_text("login (180)")
      expect(page).to have_text("spouse visa (100)")
    end

    # check per-page multipart formats are present and correct
    within("#per-page-metrics") do
      expect(page.first('th.page').text).to have_text('Page')
      expect(page.first('th.unique_pageviews').text).to have_text('Unique pageviews')
      expect(page.first('th.searches').text).to have_text('Searches started from this page')
      expect(page.first('th.problem_reports').text).to have_text('Problem reports')
      expect(page.all('td.page')[0].text).to eq('/apply-uk-visa')
      expect(page.all('td.page')[1].text).to eq('/apply-uk-visa/part-1')
      expect(page.all('td.page')[2].text).to eq('/apply-uk-visa/part-2')
      expect(page.all('td.page')[3].text).to eq('/apply-uk-visa/part-3')
      expect(page.all('td.unique_pageviews')[0].text).to eq('25k per day')
      expect(page.all('td.unique_pageviews')[1].text).to eq('24.3k per day')
      expect(page.all('td.unique_pageviews')[2].text).to eq('11k per day')
      expect(page.all('td.unique_pageviews')[3].text).to eq('7.4k per day')
      expect(page.all('td.searches')[0].text).to eq('20 per day')
      expect(page.all('td.searches')[1].text).to eq('5k per day')
      expect(page.all('td.searches')[2].text).to eq('5.33k per day')
      expect(page.all('td.searches')[3].text).to eq('9k per day')
      expect(page.all('td.problem_reports')[0].text).to eq('7 per week')
      expect(page.all('td.problem_reports')[1].text).to eq('7 per week')
      expect(page.all('td.problem_reports')[2].text).to eq('15 per week')
      expect(page.all('td.problem_reports')[3].text).to eq('12 per week')
    end

    within("#needs") do
      expect(page).to have_text("As a non-EEA national")
    end
  end

  scenario "Seeing how many users are leaving via the site search" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Searches started from this page 20 per day")
  end

  scenario "Seeing how problem reports are left" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Problem reports 7 per week")
  end

  scenario "Seeing what terms users are searching for" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("login (180)")
    expect(page).to have_text("spouse visa (100)")
  end

  scenario "Seeing where there aren’t any recorded user needs" do
    stub_metadata_api_has_slug('some-slug', metadata_api_response_with_no_needs)

    visit "/info/some-slug"

    expect(page).to have_text("There aren’t any validated needs for this page.")
  end

  scenario "When there isn't any performance data available" do
    stub_metadata_api_has_slug('some-slug', metadata_api_response_with_no_performance_data)

    visit "/info/some-slug"

    expect(page).to have_text("Unique pageviews 0 per day")
    expect(page).to have_text("Searches started from this page 0 per day")
  end

  scenario "When no information is available for a given slug" do
    stub_metadata_api_has_no_data_for_slug('slug-without-info')

    visit "/info/slug-without-info"

    expect(page.status_code).to eq(404)
  end

  scenario "when a slug that needs encoding is provided" do
    stub_metadata_api_has_slug('government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8', metadata_api_response_for_apply_uk_visa)

    visit '/info/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8'

    expect(page.status_code).to eq(200)
  end

  scenario "shows the user need when it's valid" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_for_apply_uk_visa)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("User needs and metrics")
    expect(page).to have_text("non-EEA national")
    expect(page).to have_text("apply for a UK visa")
    expect(page).to have_text("I can come to the UK to visit, study or work")
  end

  scenario "doesn't show the user need when it isn't valid" do
    stub_metadata_api_has_slug('apply-uk-visa', metadata_api_response_with_an_invalid_need)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("User needs and metrics")
    expect(page).to_not have_text("non-EEA national")
    expect(page).to_not have_text("apply for a UK visa")
    expect(page).to_not have_text("I can come to the UK to visit, study or work")

    expect(page).to have_text("There aren’t any validated needs for this page.")
  end
end
