Feature: Helpers

  Scenario: `path_list` helper
    Given a fixture app "helper-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the file "build/index.html" should contain "No Path List"
    And the file "build/page/list/index.html" should contain "<li>page:/page/</li>"
    And the file "build/page/list/index.html" should contain "<li>list:/page/list/</li>"

