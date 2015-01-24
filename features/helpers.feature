Feature: Helpers

  Scenario: `page_list` helper
    Given a fixture app "page-list-app"
    When I run `middleman build`
    Then the exit status should be 0

