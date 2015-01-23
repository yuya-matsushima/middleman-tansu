Feature: Tansu Command

  Scenario: `middleman tansu` create a markdown file with frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"

  Scenario: `middleman tansu` create a markdown file that has subdirectory
    Given a fixture app "empty-app"
    When I run `middleman tansu foo/bar/baz`
    Then the exit status should be 0
    And a file named "source/foo/bar/baz.html.md" should exist
    And the file "source/foo/bar/baz.html.md" should contain "title: baz"
    And the file "source/foo/bar/baz.html.md" should not contain "title: foo/bar/baz"
    And the file "source/foo/bar/baz.html.md" should contain "author:"
    And the file "source/foo/bar/baz.html.md" should contain "date:"

  Scenario: `middleman tansu -f slim` create a slim file
    Given a fixture app "empty-app"
    When I run `middleman tansu -f slim foo`
    Then the exit status should be 0
    And a file named "source/foo.html.slim" should exist
    And the file "source/foo.html.slim" should contain "title: foo"
    And the file "source/foo.html.slim" should contain "author:"
    And the file "source/foo.html.slim" should contain "date:"

  Scenario: `middleman tansu -d 2014-01-22` create file with date frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu -d 2014-01-04 foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date: 2014-01-04 00:00:00 UTC"

  Scenario: `middleman tansu -a "John Doe"` create file with author frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu -a "John Doe" foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author: John Doe"
    And the file "source/foo.html.md" should contain "date:"
