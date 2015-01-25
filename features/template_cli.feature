Feature: Template CLI

  Scenario: Create a new project
    Given I run `middleman init MY_PROJECT --template tansu`
    Then the exit status should be 0
    When I cd to "MY_PROJECT"
    Then the following files should exist:
      | Gemfile                                |
      | .gitignore                             |
      | config.rb                              |
      | source/layouts/layout.slim             |
      | source/stylesheets/all.css.sass        |
      | source/stylesheets/github-markdown.css |
      | source/templates/index.html.slim       |
