module MetadataAPIHelpers
  def metadata_api_response_for_apply_uk_visa
    {
      "performance" => {
        "page_views" => [
          {
            "value" => 25000,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-03T00:00:00Z",
          },
          {
            "value" => 24000,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-01T00:00:00Z",
          },
          {
            "value" => 26000,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-02T00:00:00Z",
          }
        ],
        "problem_reports" => [
          {
            "value" => 1,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-01T00:00:00Z",
          },
          {
            "value" => 2,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-02T00:00:00Z",
          },
          {
            "value" => 3,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-03T00:00:00Z",
          },
          {
            "value" => 0,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-04T00:00:00Z",
          },
          {
            "value" => 1,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-05T00:00:00Z",
          },
          {
            "value" => 0,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-06T00:00:00Z",
          },
          {
            "value" => 0,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-07T00:00:00Z",
          }
        ],
        "searches" => [
          {
            "value" => 20,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-03T00:00:00Z",
          },
          {
            "value" => 15,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-01T00:00:00Z",
          },
          {
            "value" => 25,
            "path" => "/apply-uk-visa",
            "timestamp" => "2014-07-02T00:00:00Z",
          }
        ],
        "search_terms" => [
          {
            "TotalSearches" => 180,
            "Keyword" => "login",
          },
          {
            "TotalSearches" => 100,
            "Keyword" => "spouse visa",
          }
        ],
      },
      "_response_info" => { "status" => "ok" }
    }
  end

  def metadata_api_response_with_no_performance_data
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["performance"] = {}
    end
  end

  def metadata_api_response_for_multipart_artefact
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["performance"]["page_views"] += [
        {
          "value" => 25000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 26000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 22000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 10000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 11000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 12000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 8000,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 7867,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 6325,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
      ]
      response["performance"]["searches"] += [
        {
          "value" => 4000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 5000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 6000,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 5000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 5000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 6000,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 8000,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 9000,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 10000,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-01T00:00:00Z"
        },
      ]
      response["performance"]["problem_reports"] += [
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 2,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 3,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 0,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-04T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-05T00:00:00Z",
        },
        {
          "value" => 0,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-06T00:00:00Z",
        },
        {
          "value" => 0,
          "path" => "/apply-uk-visa/part-1",
          "timestamp" => "2014-07-07T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 2,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 3,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 3,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-04T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-05T00:00:00Z",
        },
        {
          "value" => 5,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-06T00:00:00Z",
        },
        {
          "value" => 0,
          "path" => "/apply-uk-visa/part-2",
          "timestamp" => "2014-07-07T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-01T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-02T00:00:00Z",
        },
        {
          "value" => 3,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-03T00:00:00Z",
        },
        {
          "value" => 4,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-04T00:00:00Z",
        },
        {
          "value" => 1,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-05T00:00:00Z",
        },
        {
          "value" => 2,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-06T00:00:00Z",
        },
        {
          "value" => 0,
          "path" => "/apply-uk-visa/part-3",
          "timestamp" => "2014-07-07T00:00:00Z",
        },
      ]
    end
  end
end

RSpec.configure do |c|
  c.include MetadataAPIHelpers
end
