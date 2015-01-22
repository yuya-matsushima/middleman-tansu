Feature: Tansu Command

  Scenario: middleman tansu create a markdown file with frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"

