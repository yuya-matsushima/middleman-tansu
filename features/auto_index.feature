Feature: Auto index page

  Scenario: Create index file in directories that have "index.html"
    Given a fixture app "drawer-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                          |
      | build/empty_dir/index.html                |
      | build/empty_dir/sub_empty_dir/index.html  |
      | build/empty_dir/sub_empty_dir/sample.html |
      | build/not_empty_dir/index.html            |
    And the file "build/index.html" should contain "Proxy Template"
    And the file "build/empty_dir/index.html" should contain "Proxy Template"
    And the file "build/empty_dir/sub_empty_dir/index.html" should contain "Proxy Template"
    And the file "build/empty_dir/sub_empty_dir/sample.html" should contain "Sample"
    And the file "build/not_empty_dir/index.html" should contain "Not Empty"

  Scenario: Create index file in directories that have "index.html" without "build/index.html"
    Given a fixture app "drawer-app"
    And a file named "source/index.html.erb" with:
      """
      <h1>Root Index</h1>
      """
    When I run `middleman build`
    Then the exit status should be 0
    And a file named "build/index.html" should exist
    And the file "build/index.html" should contain "Root Index"

  Scenario: Don't create index file in default exclude directories
    Given a fixture app "drawer-app"
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should not exist:
      | build/images/index.html       |
      | build/stylesheets/index.html  |
      | build/javascripts/index.html  |
      | build/layouts/index.html      |
      | build/templates/index.html    |

  Scenario: Don't create a file in exclude_path option
    Given a fixture app "drawer-app"
    And a file named "config.rb" with:
      """
      activate :tansu, :exclude_path => %w(exclude not_exclude/exclude)
      """
    And a directory named "source/exclude"
    And a directory named "source/not_exclude/exclude"
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                          |
      | build/empty_dir/index.html                |
      | build/empty_dir/sub_empty_dir/index.html  |
      | build/empty_dir/sub_empty_dir/sample.html |
      | build/not_empty_dir/index.html            |
      | build/not_exclude/index.html              |
    And the following files should not exist:
      | build/exclude/index.html                  |
      | build/not_exclude/exclude/index.html      |

  Scenario: Use :index_template_name option
    Given a fixture app "drawer-app"
    And a file named "config.rb" with:
      """
      activate :tansu, :index_template_name => "template.html"
      """
    And a file named "source/templates/template.html.erb" with:
      """
      <h1>template.html.erb</h1>
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                          |
      | build/empty_dir/index.html                |
      | build/empty_dir/sub_empty_dir/index.html  |
      | build/empty_dir/sub_empty_dir/sample.html |
      | build/not_empty_dir/index.html            |
    And the file "build/index.html" should contain "template.html.erb"
    And the file "build/empty_dir/index.html" should contain "template.html.erb"
    And the file "build/empty_dir/sub_empty_dir/index.html" should contain "template.html.erb"
    And the file "build/empty_dir/sub_empty_dir/sample.html" should contain "Sample"
    And the file "build/not_empty_dir/index.html" should contain "Not Empty"

  Scenario: Use :templates_dir option
    Given a fixture app "drawer-app"
    And a file named "config.rb" with:
      """
      activate :tansu, :templates_dir => "alt_templates"
      """
    And a directory named "source/alt_templates"
    And a file named "source/alt_templates/index.html.erb" with:
      """
      <h1>Alt Template</h1>
      """
    And a file named "source/templates/index.html.erb" with:
      """
      <h1>Old Template</h1>
      """
    When I run `middleman build`
    Then the exit status should be 0
    And the following files should exist:
      | build/index.html                          |
      | build/empty_dir/index.html                |
      | build/empty_dir/sub_empty_dir/index.html  |
      | build/empty_dir/sub_empty_dir/sample.html |
      | build/not_empty_dir/index.html            |
      | build/templates/index.html                |
    And the file "build/index.html" should contain "Alt Template"
    And the file "build/empty_dir/index.html" should contain "Alt Template"
    And the file "build/empty_dir/sub_empty_dir/index.html" should contain "Alt Template"
    And the file "build/empty_dir/sub_empty_dir/sample.html" should contain "Sample"
    And the file "build/not_empty_dir/index.html" should contain "Not Empty"
    And the file "build/templates/index.html" should contain "Old Template"
