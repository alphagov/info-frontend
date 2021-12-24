require "rails_helper"
require "gds_api/test_helpers/content_store"

feature "Info page" do
  include GdsApi::TestHelpers::ContentStore

  before do
    @apply_for_a_uk_visa_need = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "need",
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
            "What documents to provide",
          ],
        },
      )
    end

    supertype_fields = @apply_for_a_uk_visa_need.keys.select { |field| field.end_with? "supertype" }
    fields_to_exclude = %w[
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
    ] + supertype_fields

    @apply_uk_visa_content = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "specialist_document",
    ) do |payload|
      payload.merge(
        title: "Apply for a UK visa",
        links: {
          meets_user_needs: [@apply_for_a_uk_visa_need.except(*fields_to_exclude)],
        },
      )
    end

    @apply_uk_visa_content_multipart = GovukSchemas::RandomExample.for_schema(
      frontend_schema: "guide",
    ) do |payload|
      payload.merge(
        title: "Apply for a UK visa",
        links: {
          meets_user_needs: [@apply_for_a_uk_visa_need.except(*fields_to_exclude)],
        },
        details: {
          parts: [
            {
              slug: "part-1",
              title: "Part 1",
              body: "Part 1",
            },
            {
              slug: "part-2",
              title: "Part 2",
              body: "Part 2",
            },
            {
              slug: "part-3",
              title: "Part 3",
              body: "Part 3",
            },
          ],
        },
      )
    end

    @apply_uk_visa_content_with_no_needs = @apply_uk_visa_content.merge(
      title: "Apply for a UK visa",
      links: {
        meets_user_needs: [],
      },
    )
  end

  scenario "Understanding the needs of a page" do
    stub_content_store_has_item("/apply-uk-visa", @apply_uk_visa_content)

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

    expect(page.response_headers["Cache-Control"]).to eq("max-age=900, public")
  end

  scenario "Seeing where there aren’t any recorded user needs" do
    stub_content_store_has_item("/some-slug", @apply_uk_visa_content_with_no_needs)

    visit "/info/some-slug"

    expect(page).to have_text("There aren’t any validated needs for this page.")
  end

  scenario "When no information is available for a given slug" do
    stub_content_store_does_not_have_item("/slug-without-info")

    visit "/info/slug-without-info"

    expect(page.status_code).to eq(404)
  end

  scenario "when a slug that needs encoding is provided" do
    stub_content_store_has_item("/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8", @apply_uk_visa_content)

    visit "/info/government/publications/apply-for-a-uk-visa-in-china/%E5%9C%A8"

    expect(page.status_code).to eq(200)
  end

  scenario "shows the user need when it's valid" do
    stub_content_store_has_item("/apply-uk-visa", @apply_uk_visa_content)

    visit "/info/apply-uk-visa"

    expect(page).to have_text("User needs and metrics")
    expect(page).to have_text("non-EEA national")
    expect(page).to have_text("apply for a UK visa")
    expect(page).to have_text("I can come to the UK to visit, study or work")
  end
end
