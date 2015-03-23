Feature: Tansu Command

  Scenario: `middleman tansu` create a markdown file with frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu foo`
    Then the exit status should be 0
    And the output should contain "create tansu page: foo.html.md"
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"

  Scenario: `middleman tansu` create a markdown file that has subdirectory
    Given a fixture app "empty-app"
    When I run `middleman tansu foo/bar/baz`
    Then the exit status should be 0
    And the output should contain "create tansu page: foo/bar/baz.html.md"
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
    And I set the timezone to "UTC"
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

  Scenario: `middleman tansu --frontmatter "category: sample"` create file with category frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu --frontmatter "category: sample" foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "category: sample"

  Scenario: `middleman tansu --frontmatter "category: sample, tags: markdown"` create file with category frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu --frontmatter "category: sample, tags: markdown" foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "category: sample"
    And the file "source/foo.html.md" should contain "tags: markdown"

  Scenario: `middleman tansu --frontmatter "category:sample,tags:markdown"` create file with category frontmatter
    Given a fixture app "empty-app"
    When I run `middleman tansu --frontmatter "category: sample, tags: markdown" foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "category: sample"
    And the file "source/foo.html.md" should contain "tags: markdown"

  Scenario: `middleman tansu` create a markdown
    Given a fixture app "empty-app"
    And I set the timezone to "UTC"
    When I run `middleman tansu foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "UTC"

  Scenario: `middleman tansu` create a markdown file with TZ="Tokyo"
    Given a fixture app "empty-app"
    And I set the timezone to "Tokyo"
    When I run `middleman tansu foo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "+0900"

  Scenario: `middleman tansu` create a markdown file with -z option
    Given a fixture app "empty-app"
    And I set the timezone to "UTC"
    When I run `middleman tansu foo -z Tokyo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "+0900"

  Scenario: `middleman tansu` create a markdown file with -z option(downcase)
    Given a fixture app "empty-app"
    And I set the timezone to "UTC"
    When I run `middleman tansu foo -z tokyo`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "+0900"

  Scenario: `middleman tansu` create a markdown file with -z option(uppercase)
    Given a fixture app "empty-app"
    And I set the timezone to "UTC"
    When I run `middleman tansu foo -z TOKYO`
    Then the exit status should be 0
    And a file named "source/foo.html.md" should exist
    And the file "source/foo.html.md" should contain "title: foo"
    And the file "source/foo.html.md" should not contain "title: foo.html.md"
    And the file "source/foo.html.md" should contain "author:"
    And the file "source/foo.html.md" should contain "date:"
    And the file "source/foo.html.md" should contain "+0900"
