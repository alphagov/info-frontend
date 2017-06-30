module StatisticsHelpers
  def performance_platform_response_for_apply_uk_visa
    {
        search_terms: performance_platform_response_for_search_terms,
        searches: performance_platform_response_for_searches,
        page_views: performance_platform_response_for_page_views,
        problem_reports: performance_platform_response_for_problem_reports
    }
  end

  def performance_platform_response_for_multipart_artefact
    {
        search_terms: performance_platform_response_for_search_terms,
        searches: performance_platform_response_for_multipart_searches,
        page_views: performance_platform_response_for_multipart_page_views,
        problem_reports: performance_platform_response_for_multipart_problem_reports
    }
  end

  def performance_platform_response_with_no_performance_data
    {}
  end

  def performance_platform_response_for_searches
    {
        data: [
            {
                pagePath: '/apply-uk-visa',
                values: [
                    {
                        _count: 4,
                        _end_at: '2014-09-01T00:00:00+00:00',
                        _start_at: '2014-09-01T00:00:00+00:00',
                        'searchUniques:sum': 71
                    },
                    {
                        _count: 5,
                        _end_at: '2014-09-05T00:00:00+00:00',
                        _start_at: '2014-09-04T00:00:00+00:00',
                        'searchUniques:sum': 72
                    },
                    {
                        _count: 6,
                        _end_at: '2014-09-07T00:00:00+00:00',
                        _start_at: '2014-09-06T00:00:00+00:00',
                        'searchUniques:sum': 73
                    }
                ]
            }
        ]
    }
  end

  def performance_platform_response_for_page_views
    {
        data: [
            {
                pagePath: '/apply-uk-visa',
                values: [
                    {
                        _count: 1,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 25931
                    },
                    {
                        _count: 2,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 25932
                    },
                    {
                        _count: 3,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 25933
                    }
                ]
            }
        ]
    }
  end

  def performance_platform_response_for_problem_reports
    {
        data: [
            {
                pagePath: '/apply-uk-visa',
                values: [
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 10
                    },
                    {
                        _count: 5,
                        _end_at: '2014-09-04T00:00:00+00:00',
                        _start_at: '2014-09-03T00:00:00+00:00',
                        'total:sum': 20
                    },
                    {
                        _count: 5,
                        _end_at: '2014-09-05T00:00:00+00:00',
                        _start_at: '2014-09-04T00:00:00+00:00',
                        'total:sum': 30
                    }
                ]
            }
        ]
    }
  end

  def performance_platform_response_for_search_terms
    {
        data: [
            {
                _count: 8,
                _group_count: 8,
                searchKeyword: 'employer access',
                'searchUniques:sum': 126,
                values: [{
                               _count: 1,
                               'searchUniques:sum': 100,
                               _end_at: '2014-09-02T00:00:00+00:00',
                               _start_at: '2014-09-01T00:00:00+00:00'
                           },
                         {
                             _count: 2,
                             'searchUniques:sum': 200,
                             _end_at: '2014-09-03T00:00:00+00:00',
                             _start_at: '2014-09-02T00:00:00+00:00'
                         },
                         {
                             _count: 3,
                             'searchUniques:sum': 300,
                             _end_at: '2014-09-04T00:00:00+00:00',
                             _start_at: '2014-09-03T00:00:00+00:00'
                         }]
            },
            {
                _count: 3,
                _group_count: 3,
                searchKeyword: 'pupil premium',
                'searchUniques:sum': 45,
                values: [{
                               _count: 1,
                               'searchUniques:sum': 15,
                               _end_at: '2014-09-02T00:00:00+00:00',
                               _start_at: '2014-09-01T00:00:00+00:00'
                           },
                         {
                             _count: 2,
                             'searchUniques:sum': 20,
                             _end_at: '2014-09-02T00:00:00+00:00',
                             _start_at: '2014-09-01T00:00:00+00:00'
                         },
                         {
                             _count: 3,
                             'searchUniques:sum': 25,
                             _end_at: '2014-09-02T00:00:00+00:00',
                             _start_at: '2014-09-01T00:00:00+00:00'
                         }]
            },
            {
                _count: 4,
                _group_count: 4,
                searchKeyword: 's2s',
                'searchUniques:sum': 104,
                values: [{
                               _count: 1,
                               'searchUniques:sum': 5,
                               _end_at: '2014-09-02T00:00:00+00:00',
                               _start_at: '2014-09-03T00:00:00+00:00'
                           },
                         {
                             _count: 2,
                             'searchUniques:sum': 10,
                             _end_at: '2014-09-03T00:00:00+00:00',
                             _start_at: '2014-09-02T00:00:00+00:00'
                         },
                         {
                             _count: 3,
                             'searchUniques:sum': 15,
                             _end_at: '2014-09-04T00:00:00+00:00',
                             _start_at: '2014-09-03T00:00:00+00:00'
                         }]
            }
        ]
    }
  end

  def performance_platform_response_for_multipart_searches
    performance_platform_response_for_searches.tap do |response|
      response[:data] += [
          {
              pagePath: '/apply-uk-visa/part-1',
              values: [
                  {
                      _count: 1,
                      _end_at: '2014-09-01T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 50
                  },
                  {
                      _count: 2,
                      _end_at: '2014-09-01T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 100
                  },
                  {
                      _count: 3,
                      _end_at: '2014-09-01T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 150
                  }
              ]
          },
          {
              pagePath: '/apply-uk-visa/part-2',
              values: [
                  {
                      _count: 5,
                      _end_at: '2014-09-02T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 25
                  },
                  {
                      _count: 5,
                      _end_at: '2014-09-03T00:00:00+00:00',
                      _start_at: '2014-09-02T00:00:00+00:00',
                      'searchUniques:sum': 50
                  },
                  {
                      _count: 5,
                      _end_at: '2014-09-04T00:00:00+00:00',
                      _start_at: '2014-09-03T00:00:00+00:00',
                      'searchUniques:sum': 75
                  }
              ]
          },
          {
              pagePath: '/apply-uk-visa/part-3',
              values: [
                  {
                      _count: 1,
                      _end_at: '2014-09-02T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 2
                  },
                  {
                      _count: 1,
                      _end_at: '2014-09-02T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 3
                  },
                  {
                      _count: 1,
                      _end_at: '2014-09-02T00:00:00+00:00',
                      _start_at: '2014-09-01T00:00:00+00:00',
                      'searchUniques:sum': 4
                  }
              ]
          }
      ]
    end
  end

  def performance_platform_response_for_multipart_page_views
    performance_platform_response_for_page_views.tap do |response|
      response[:data] += [
            {
                pagePath: '/apply-uk-visa/part-1',
                values: [
                    {
                        _count: 1,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 15
                    },
                    {
                        _count: 3,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 20
                    },
                    {
                        _count: 5,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 25
                    }
                ]
            },
            {
                pagePath: '/apply-uk-visa/part-2',
                values: [
                    {
                        _count: 1,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 10
                    },
                    {
                        _count: 2,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 20
                    },
                    {
                        _count: 3,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 30
                    }
                ]
            },
            {
                pagePath: '/apply-uk-visa/part-3',
                values: [
                    {
                        _count: 1,
                        _end_at: '2014-07-03T00:00:00+00:00',
                        _start_at: '2014-07-02T00:00:00+00:00',
                        'uniquePageviews:sum': 25735
                    }
                ]
            }
      ]
    end
  end

  def performance_platform_response_for_multipart_problem_reports
    performance_platform_response_for_problem_reports.tap do |response|
      response[:data] += [
            {
                pagePath: '/apply-uk-visa/part-1',
                values: [
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 71
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 72
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 73
                    }
                ]
            },
            {
                pagePath: '/apply-uk-visa/part-2',
                values: [
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 10
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 15
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 20
                    }
                ]
            },
            {
                pagePath: '/apply-uk-visa/part-3',
                values: [
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 20
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 30
                    },
                    {
                        _count: 4,
                        _end_at: '2014-09-03T00:00:00+00:00',
                        _start_at: '2014-09-02T00:00:00+00:00',
                        'total:sum': 40
                    }
                ]
            }
        ]
    end
  end
end

RSpec.configure do |c|
  c.include StatisticsHelpers
end
