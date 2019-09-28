require "gds_api/test_helpers/performance_platform/data_out"

module PerformanceData
  module TestHelpers
    module Statistics
      include GdsApi::TestHelpers::PerformancePlatform::DataOut

      def stub_performance_platform_has_slug(slug, response)
        stub_search_terms(slug, response[:search_terms])
        stub_searches(slug, false, response[:searches])
        stub_page_views(slug, false, response[:page_views])
        stub_problem_reports(slug, false, response[:problem_reports])
      end

      def stub_performance_platform_has_slug_multipart(slug, response)
        multipart = true

        stub_search_terms(slug, response[:search_terms])
        stub_searches(slug, multipart, response[:searches])
        stub_page_views(slug, multipart, response[:page_views])
        stub_problem_reports(slug, multipart, response[:problem_reports])
      end

      def stub_performance_platform_has_no_data_for_slug(slug)
        stub_search_404(slug)
        stub_page_views_404(slug)
        stub_problem_reports_404(slug)
      end
    end
  end
end
