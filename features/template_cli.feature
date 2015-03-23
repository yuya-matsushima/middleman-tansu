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
      | source/sitemap.xml.builder             |
      | source/layouts/layout.slim             |
      | source/stylesheets/all.css.sass        |
      | source/stylesheets/_gemoji.sass        |
      | source/stylesheets/pure-min.css        |
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
      | build/sitemap.xml                      |
      | build/stylesheets/all.css              |
    And the file "build/stylesheets/all.css" should contain "Pure"
    And the file "build/stylesheets/all.css" should contain ".gemoji"
    And the file "build/stylesheets/all.css" should contain ".markdown-body"
    And the file "build/index.html" should contain "middleman-tansu の簡単な紹介"
    And the helper result "build/sample.html" should contain:
      """
      <li class="current">middleman-tansu の簡単な紹介</li>
      """
    And the helper result "build/sitemap.xml" should contain:
      """
      <loc>http://localhost:4567/index.html</loc>
      """

  Scenario: sitemap.xml contains escaped URI
    Given I run `middleman init MY_PROJECT --template tansu`
    And I cd to "MY_PROJECT"
    And I run `middleman tansu マルチバイトページ`
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/マルチバイトページ.html          |
      | build/sitemap.xml                      |
    And the file "build/sitemap.xml" should contain "%E3%83%9E%E3%83%AB%E3%83%81%E3%83%90%E3%82%A4%E3%83%88%E3%83%9A%E3%83%BC%E3%82%B8"

  Scenario: Build a new project with app.config.sitemap_url
    Given I run `middleman init MY_PROJECT --template tansu`
    And a file named "MY_PROJECT/config.rb" with:
      """
      require "slim"
      require "builder"
      set :site_title, "Middleman-Tansu"
      set :sitemap_url, "http://middlemanapp.com"
      activate :tansu
      set :markdown_engine, :redcarpet
      set :markdown, :fenced_code_blocks => true, :smartypants => true, :with_toc_data => true
      activate :syntax, :inline_theme => 'github'
      """
    And I cd to "MY_PROJECT"
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                       |
      | build/sample.html                      |
      | build/sitemap.xml                      |
      | build/stylesheets/all.css              |
    And the helper result "build/sitemap.xml" should contain:
      """
      <loc>http://middlemanapp.com/index.html</loc>
      """
