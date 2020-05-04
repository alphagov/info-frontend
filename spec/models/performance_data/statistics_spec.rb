require "rails_helper"
require "performance_data/statistics"
require "performance_data/test_helpers/statistics"
require "gds_api/test_helpers/content_store"

module PerformanceData
  describe Statistics do
    include PerformanceData::TestHelpers::Statistics
    include GdsApi::TestHelpers::ContentStore

    context "getting a response from the performance platform" do
      context "with nil values" do
        it "should replace nil values with zero" do
          stub_performance_platform_has_slug("/apply-uk-visa", performance_platform_response_with_nil_values)

          statistics = Statistics.new(apply_uk_visa_content, "/apply-uk-visa")

          expect(statistics.problem_reports.last[:value]).to eql(0)
          expect(statistics.problem_reports.last[:path]).to eql("/apply-uk-visa")

          expect(statistics.page_views.last[:value]).to eql(0)
          expect(statistics.page_views.last[:path]).to eql("/apply-uk-visa")

          expect(statistics.searches.last[:value]).to eql(0)
          expect(statistics.searches.last[:path]).to eql("/apply-uk-visa")

          expect(statistics.search_terms.last[:total_searches]).to eql(0)
          expect(statistics.search_terms.last[:searches].last[:value]).to eql(0)
        end

        it "should replace nil values with zero for multipart links" do
          stub_performance_platform_has_slug_multipart("/apply-uk-visa", performance_platform_response_for_multipart_with_nil_values)

          statistics = Statistics.new(apply_uk_visa_content_multipart, "/apply-uk-visa")

          expect(statistics.problem_reports.last[:value]).to eql(0)
          expect(statistics.problem_reports.last[:path]).to eql("/apply-uk-visa/part-3")

          expect(statistics.page_views.last[:value]).to eql(0)
          expect(statistics.page_views.last[:path]).to eql("/apply-uk-visa/part-3")

          expect(statistics.searches.last[:value]).to eql(0)
          expect(statistics.searches.last[:path]).to eql("/apply-uk-visa/part-3")

          # there is no multipart version of search-terms
        end
      end
    end

    def apply_uk_visa_content
      GovukSchemas::RandomExample.for_schema(
        frontend_schema: "specialist_document",
      ) do |payload|
        payload.merge(
          title: "Apply for a UK visa",
          links: {
            meets_user_needs: [apply_for_a_uk_visa_need],
          },
        )
      end
    end

    def apply_uk_visa_content_multipart
      GovukSchemas::RandomExample.for_schema(
        frontend_schema: "guide",
      ) do |payload|
        payload.merge(
          title: "Apply for a UK visa 1",
          links: {
            meets_user_needs: [apply_for_a_uk_visa_need],
          },
          "details" => {
            "parts" => [
              {
                "slug" => "part-1",
                "title" => "Part 1",
                "body" => "Part 1",
              },
              {
                "slug" => "part-2",
                "title" => "Part 2",
                "body" => "Part 2",
              },
              {
                "slug" => "part-3",
                "title" => "Part 3",
                "body" => "Part 3",
              },
            ],
          },
        )
      end
    end

    def apply_for_a_uk_visa_need
      random_need = GovukSchemas::RandomExample.for_schema(
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

      clean_up_need(random_need)
    end

    def clean_up_need(need)
      supertype_fields = need.keys.select { |field| field.end_with? "supertype" }
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
        navigation_document_supertype
        government_document_supertype
        email_document_supertype
        links
      ] + supertype_fields
      need.except(*fields_to_exclude)
    end
  end
end
