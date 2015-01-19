module MetadataAPIHelpers
  def metadata_api_response_for_apply_uk_visa
    {"artefact"=>
      {"id"=>"https://contentapi.dev.gov.uk/apply-uk-visa.json",
       "web_url"=>"https://www.dev.gov.uk/apply-uk-visa",
       "title"=>"Apply for a UK visa",
       "format"=>"transaction",
       "details"=>
        {"need_ids"=>["100126"],
         "business_proposition"=>false,
         "description"=>
          "You can apply online for a UK visa to visit, work, study or join a family member or partner (eg spouse) already in the UK"}},
     "needs"=>
      [{"id"=>100126,
        "role"=>"non-EEA national",
        "goal"=>"apply for a UK visa",
        "benefit"=>"I can come to the UK to visit, study or work",
        "organisation_ids"=>["uk-visas-and-immigration"],
        "organisations"=>
         [{"id"=>"uk-visas-and-immigration",
           "name"=>"UK Visas and Immigration",
           "govuk_status"=>"live",
           "abbreviation"=>"UKVI",
           "parent_ids"=>["home-office"],
           "child_ids"=>[]}],
        "justifications"=>["It's something only government does"],
        "impact"=>"Has consequences for the majority of your users",
        "met_when"=>
         ["Finds out how whether they're eligible",
          "How to apply",
          "What documents to provide"],
        "yearly_user_contacts"=>0,
        "yearly_site_views"=>0,
        "yearly_need_views"=>0,
        "yearly_searches"=>0,
        "other_evidence"=>"",
        "legislation"=>"",
        "applies_to_all_organisations"=>false,
        "in_scope"=>false,
        "out_of_scope_reason"=>"",
        "duplicate_of"=>0}],
     "performance"=>
      {"page_views"=>
        [{"value"=>25000,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-03T00:00:00Z"},
         {"value"=>24000,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-01T00:00:00Z"},
         {"value"=>26000,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-02T00:00:00Z"}],
       "problem_reports"=>
        [{"value"=>1,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-01T00:00:00Z"},
         {"value"=>2,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-02T00:00:00Z"},
         {"value"=>3,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-03T00:00:00Z"},
         {"value"=>0,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-04T00:00:00Z"},
         {"value"=>1,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-05T00:00:00Z"},
         {"value"=>0,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-06T00:00:00Z"},
         {"value"=>0,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-07T00:00:00Z"}],
       "searches"=>
        [{"value"=>20,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-03T00:00:00Z"},
         {"value"=>15,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-01T00:00:00Z"},
         {"value"=>25,
          "path"=>"/apply-uk-visa",
          "timestamp"=>"2014-07-02T00:00:00Z"}],
        "search_terms"=>
         [{"TotalSearches"=>180,
           "Keyword"=>"login"},
          {"TotalSearches"=>100,
           "Keyword"=>"spouse visa"}],
         },
     "_response_info"=>{"status"=>"ok"}}
  end

  def metadata_api_response_with_no_needs
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["needs"] = []
    end
  end

  def metadata_api_response_with_no_performance_data
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["performance"] = {}
    end
  end

  def metadata_api_response_for_multipart_artefact
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["artefact"]["details"]["parts"] = [
        { "web_url" => response["artefact"]["web_url"] + "/part-1" },
        { "web_url" => response["artefact"]["web_url"] + "/part-2" },
        { "web_url" => response["artefact"]["web_url"] + "/part-3" },
      ]
      response["performance"]["page_views"] += [
        {"value"=>25000,
         "path"=>"/apply-uk-visa/part-1",
         "timestamp"=>"2014-07-03T00:00:00Z"},
        {"value"=>24000,
         "path"=>"/apply-uk-visa/part-2",
         "timestamp"=>"2014-07-01T00:00:00Z"},
        {"value"=>26000,
         "path"=>"/apply-uk-visa/part-3",
         "timestamp"=>"2014-07-02T00:00:00Z"}
      ]
      response["performance"]["searches"] += [
        {"value"=>4000,
         "path"=>"/apply-uk-visa/part-1",
         "timestamp"=>"2014-07-03T00:00:00Z"},
        {"value"=>5000,
         "path"=>"/apply-uk-visa/part-2",
         "timestamp"=>"2014-07-01T00:00:00Z"},
        {"value"=>6000,
         "path"=>"/apply-uk-visa/part-3",
         "timestamp"=>"2014-07-02T00:00:00Z"}
      ]
      response["performance"]["problem_reports"] += [
        {"value"=>200,
         "path"=>"/apply-uk-visa/part-1",
         "timestamp"=>"2014-07-03T00:00:00Z"},
        {"value"=>250,
         "path"=>"/apply-uk-visa/part-2",
         "timestamp"=>"2014-07-01T00:00:00Z"},
        {"value"=>100,
         "path"=>"/apply-uk-visa/part-3",
         "timestamp"=>"2014-07-02T00:00:00Z"}
      ]
    end
  end
end

RSpec.configure do |c|
  c.include MetadataAPIHelpers
end
