Feature: Template CLI

  Scenario: Create a new project
    Given I run `middleman init MY_PROJECT --template tansu`
    And the exit status should be 0
    When I cd to "MY_PROJECT"
    Then the following files should exist:
      | Gemfile                                |
      | .gitignore                             |
      | config.rb                              |
      | source/sample.html.md                  |
      | source/layouts/layout.slim             |
      | source/stylesheets/all.css.sass        |
      | source/stylesheets/github-markdown.css |
      | source/templates/index.html.slim       |

  Scenario: Build a new project
    Given I run `middleman init MY_PROJECT --template tansu`
    And I cd to "MY_PROJECT"
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                       |
      | build/sample.html                      |
      | build/stylesheets/all.css              |
    And the file "build/index.html" should contain "middleman-tansu の簡単な紹介"
    And the helper result "build/sample.html" should contain:
      """
      <li class="current">middleman-tansu の簡単な紹介</li>
      """

