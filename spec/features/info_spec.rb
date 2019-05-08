# coding: utf-8

require "rails_helper"
require "performance_data/test_helpers/statistics"
require "gds_api/test_helpers/content_store"

feature "Info page" do
  include PerformanceData::TestHelpers::Statistics
  include GdsApi::TestHelpers::ContentStore

  before do
    @apply_for_a_uk_visa_need = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "need"
    ) do |payload|
      payload.merge(
        "details" => {
          "role" => "As a non-EEA national",
          "goal" => "I need to apply for a UK visa",
          "benefit" => "So that I can come to the UK to visit, study or work",
          "justifications" => ["It's something only government does"],
          "met_when" => [
            "Finds out how whether they're eligible",
            "How to apply",
            "What documents to provide"
          ],
        }
      )
    end

    supertype_fields = @apply_for_a_uk_visa_need.keys.select { |field| field.end_with? "supertype" }
    fields_to_exclude = %w(
      rendering_app
      withdrawn_notice
      last_edited_at
      updated_at
      first_published_at
      publishing_app
      format
      phase
      publishing_request_id
      links
    ) + supertype_fields

    @apply_uk_visa_content = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "specialist_document"
    ) do |payload|
      payload.merge(
        title: "Apply for a UK visa",
        links: {
          meets_user_needs: [@apply_for_a_uk_visa_need.except(*fields_to_exclude)]
        }
      )
    end

    @apply_uk_visa_content_multipart = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "guide"
    ) do |payload|
      payload.merge(
        title: "Apply for a UK visa",
        links: {
          meets_user_needs: [@apply_for_a_uk_visa_need.except(*fields_to_exclude)]
        },
        details: {
          parts: [
            {
              slug: 'part-1',
              title: 'Part 1',
              body: 'Part 1',
            },
            {
              slug: 'part-2',
              title: 'Part 2',
              body: 'Part 2',
            },
            {
              slug: 'part-3',
              title: 'Part 3',
              body: 'Part 3',
            },
          ]
        },
      )
    end

    @apply_uk_visa_content_with_no_needs = @apply_uk_visa_content.merge(
      title: "Apply for a UK visa",
      links: {
        meets_user_needs: []
      }
    )
  end

  scenario "Understanding the needs of a page" do
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

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
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Unique pageviews\n25.9k per day")
  end

  scenario "Seeing metrics for multi-part formats" do
    stub_performance_platform_has_slug_multipart('/apply-uk-visa', performance_platform_response_for_multipart_artefact)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content_multipart)

    visit "/info/apply-uk-visa"

    within("#lead-metrics") do
      # check lead metrics for multipart formats are summed
      # across all pages in the format
      expect(page).to have_text("Unique pageviews\n104k per day")
      expect(page).to have_text("Searches started\n135 per day")
      expect(page).to have_text("Problem reports\n959 per week")
      expect(page).to have_text("employer access (126)")
      expect(page).to have_text("s2s (104)")
      expect(page).to have_text("pupil premium (45)")
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
      expect(page.all('td.unique_pageviews')[0].text).to eq('25.9k per day')
      expect(page.all('td.unique_pageviews')[1].text).to eq('20 per day')
      expect(page.all('td.unique_pageviews')[2].text).to eq('20 per day')
      expect(page.all('td.unique_pageviews')[3].text).to eq('25.7k per day')
      expect(page.all('td.searches')[0].text).to eq('72 per day')
      expect(page.all('td.searches')[1].text).to eq('100 per day')
      expect(page.all('td.searches')[2].text).to eq('50 per day')
      expect(page.all('td.searches')[3].text).to eq('3 per day')
      expect(page.all('td.problem_reports')[0].text).to eq('140 per week')
      expect(page.all('td.problem_reports')[1].text).to eq('504 per week')
      expect(page.all('td.problem_reports')[2].text).to eq('105 per week')
      expect(page.all('td.problem_reports')[3].text).to eq('210 per week')
    end

    within("#needs") do
      expect(page).to have_text("As a non-EEA national")
    end
  end

  scenario "Seeing how many users are leaving via the site search" do
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Searches started from this page\n72 per day")
  end

  scenario "Seeing how problem reports are left" do
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("Problem reports\n140 per week")
  end

  scenario "Seeing what terms users are searching for" do
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("employer access (126)")
    expect(page).to have_text("pupil premium (45)")
  end

  scenario "Seeing where there aren’t any recorded user needs" do
    stub_performance_platform_has_slug('/some-slug', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/some-slug', @apply_uk_visa_content_with_no_needs)

    visit "/info/some-slug"

    expect(page).to have_text("There aren’t any validated needs for this page.")
  end

  scenario "When there isn't any performance data available" do
    stub_performance_platform_has_slug('/some-slug', performance_platform_response_with_no_performance_data)
    content_store_has_item('/some-slug', @apply_uk_visa_content)

    visit "/info/some-slug"

    expect(page).to have_text("Unique pageviews\n0 per day")
    expect(page).to have_text("Searches started from this page\n0 per day")
  end

  scenario "When no information is available for a given slug" do
    stub_performance_platform_has_no_data_for_slug('/slug-without-info')
    content_store_does_not_have_item('/slug-without-info')

    visit "/info/slug-without-info"

    expect(page.status_code).to eq(404)
  end

  scenario "when a slug that needs encoding is provided" do
    stub_performance_platform_has_slug('/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8', @apply_uk_visa_content)

    visit '/info/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8'

    expect(page.status_code).to eq(200)
  end

  scenario "shows the user need when it's valid" do
    stub_performance_platform_has_slug('/apply-uk-visa', performance_platform_response_for_apply_uk_visa)
    content_store_has_item('/apply-uk-visa', @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("User needs and metrics")
    expect(page).to have_text("non-EEA national")
    expect(page).to have_text("apply for a UK visa")
    expect(page).to have_text("I can come to the UK to visit, study or work")
  end
end
