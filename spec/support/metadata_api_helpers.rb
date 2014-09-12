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
     "_response_info"=>{"status"=>"ok"}}
  end

  def metadata_api_response_with_no_needs
    metadata_api_response_for_apply_uk_visa.tap do |response|
      response["needs"] = []
    end
  end
end

RSpec.configure do |c|
  c.include MetadataAPIHelpers
end
