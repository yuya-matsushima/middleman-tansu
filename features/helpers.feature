Feature: Helpers

  Scenario: `path_list` helper
    Given a fixture app "path-list-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the file "build/index.html" should contain "No Path List"
    And the file "build/page/list/index.html" should contain "<li>page:/page/</li>"
    And the file "build/page/list/index.html" should contain "<li>list:/page/list/</li>"

  Scenario: `breadcrumbs` helper
    Given a fixture app "breadcrumbs-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0

    # /index.html
    And the helper result "build/index.html" should contain '<ul class="breadcrumbs">'
    And the helper result "build/index.html" should contain '<li class="root"><a href="/">Top</a></li>'

    # /dir/page.html
    And the helper result "build/dir/page.html" should contain '<li class="root"><a href="/">Top</a></li>'
    And the helper result "build/dir/page.html" should contain '<li><a href="/dir/">dir</a></li>'
    And the helper result "build/dir/page.html" should contain '<li class="current">page</li>'

  Scenario: `breadcrumbs` helper with params
    Given a fixture app "breadcrumbs-params-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0

    # /index.html
    And the helper result "build/index.html" should contain '<ul class="bread-links">'
    And the helper result "build/index.html" should contain '<li class="root"><a href="/">Home</a></li>'

  Scenario: `children_pages` helper
    Given a fixture app "children-pages-app"
    And a file named "source/templates/index.html.erb" with:
      """
      <ul>
        <% children_pages.each do |page| %>
          <li><%= link_to(page_name(page.path), page_url(page.path)) %></li>
        <% end %>
      </ul>
      """
    When I run `middleman build --verbose`
    Then the exit status should be 0
