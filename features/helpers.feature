Feature: Helpers

  Scenario: `path_list` helper
    Given a fixture app "path-list-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the helper result "build/index.html" should contain '<p>No Path List</p>'
    And the helper result "build/page/list/index.html" should contain:
      """
            <li>page:/page/</li>
            <li>list:/page/list/</li>
      """

  Scenario: `breadcrumbs` helper
    Given a fixture app "breadcrumbs-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0

    # /index.html
    And the helper result "build/index.html" should contain '<ul class="breadcrumbs">'
    And the helper result "build/index.html" should contain '<li class="root"><a href="/">Top</a></li>'

    # /dir/page.html
    And the helper result "build/dir/page.html" should contain:
      """
      <li class="root"><a href="/">Top</a></li>
      <li><a href="/dir/">dir</a></li>
      <li class="current">page</li>
      """

  Scenario: `breadcrumbs` helper with params
    Given a fixture app "breadcrumbs-params-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0

    # /index.html
    And the helper result "build/index.html" should contain '<ul class="bread-links">'
    And the helper result "build/index.html" should contain '<li class="root"><a href="/">Home</a></li>'

  Scenario: `breadcrumbs` helper with index page that has title Frontmatter
    Given a fixture app "breadcrumbs-has-title-app"
    When I run `middleman build --verbose`
    Then the exit status should be 0

    # /index.html
    And the helper result "build/index.html" should contain '<ul class="breadcrumbs">'
    And the helper result "build/index.html" should contain '<li class="root"><a href="/">Root Page</a></li>'

    # /dir/page.html
    And the helper result "build/dir/sub_dir/page.html" should contain:
      """
      <li class="root"><a href="/">Root Page</a></li>
      <li><a href="/dir/">Dir/Index Title</a></li>
      <li><a href="/dir/sub_dir/">sub_dir</a></li>
      <li class="current">Dir/Page Title</li>
      """

  Scenario: `children_pages` helper
    Given a fixture app "children-pages-app"
    And a file named "source/templates/index.html.erb" with:
      """
      <ul>
        <% children_pages.each do |page| %>
          <li><%= link_to(page_name(page), page_url(page)) %></li>
        <% end %>
      </ul>
      """
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the helper result "build/index.html" should contain:
      """
          <li><a href="/dir1/">dir1</a></li>
          <li><a href="/dir2/">dir2</a></li>
          <li><a href="/page1.html">Page1 Title</a></li>
      """
    And the helper result "build/dir1/index.html" should contain:
      """
          <li><a href="/dir1/sub_dir1/">dir1/sub_dir1</a></li>
          <li><a href="/dir1/sub_dir2/">dir1/sub_dir2</a></li>
          <li><a href="/dir1/page1.html">dir1/Page1 Title</a></li>
          <li><a href="/dir1/page2.html">dir1/Page2 Title</a></li>
          <li><a href="/dir1/page3.html">dir1/Page3 Title</a></li>
          <li><a href="/dir1/no-title-page.html">dir1/no-title-page</a></li>
      """

  Scenario: `children_pages` helper with "order_by = :desc" option
    Given a fixture app "children-pages-app"
    And a file named "source/templates/index.html.erb" with:
      """
      <ul>
        <% children_pages(:date, :desc).each do |page| %>
          <li><%= link_to(page_name(page), page_url(page)) %></li>
        <% end %>
      </ul>
      """
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the helper result "build/index.html" should contain:
      """
          <li><a href="/dir2/">dir2</a></li>
          <li><a href="/dir1/">dir1</a></li>
          <li><a href="/page1.html">Page1 Title</a></li>
      """
    And the helper result "build/dir1/index.html" should contain:
      """
          <li><a href="/dir1/sub_dir2/">dir1/sub_dir2</a></li>
          <li><a href="/dir1/sub_dir1/">dir1/sub_dir1</a></li>
          <li><a href="/dir1/no-title-page.html">dir1/no-title-page</a></li>
          <li><a href="/dir1/page3.html">dir1/Page3 Title</a></li>
          <li><a href="/dir1/page2.html">dir1/Page2 Title</a></li>
          <li><a href="/dir1/page1.html">dir1/Page1 Title</a></li>
      """

  Scenario: `children_pages` helper with "key = :category" option
    Given a fixture app "children-pages-with-category-app"
    And a file named "source/templates/index.html.erb" with:
      """
      <ul>
        <% children_pages(:category).each do |page| %>
          <li><%= link_to(page_name(page), page_url(page)) %></li>
        <% end %>
      </ul>
      """
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the helper result "build/dir1/index.html" should contain:
      """
          <li><a href="/dir1/sub_dir1/">dir1/sub_dir1</a></li>
          <li><a href="/dir1/sub_dir2/">dir1/sub_dir2</a></li>
          <li><a href="/dir1/page1.html">dir1/Page1 Title</a></li>
          <li><a href="/dir1/page2.html">dir1/Page2 Title</a></li>
          <li><a href="/dir1/page3.html">dir1/Page3 Title</a></li>
          <li><a href="/dir1/no-title-page.html">dir1/no-title-page</a></li>
      """

  Scenario: `children_pages` helper with "key = :category" and "order_by = :desc" option
    Given a fixture app "children-pages-with-category-app"
    And a file named "source/templates/index.html.erb" with:
      """
      <ul>
        <% children_pages(:category, :desc).each do |page| %>
          <li><%= link_to(page_name(page), page_url(page)) %></li>
        <% end %>
      </ul>
      """
    When I run `middleman build --verbose`
    Then the exit status should be 0
    And the helper result "build/dir1/index.html" should contain:
      """
          <li><a href="/dir1/sub_dir2/">dir1/sub_dir2</a></li>
          <li><a href="/dir1/sub_dir1/">dir1/sub_dir1</a></li>
          <li><a href="/dir1/no-title-page.html">dir1/no-title-page</a></li>
          <li><a href="/dir1/page3.html">dir1/Page3 Title</a></li>
          <li><a href="/dir1/page2.html">dir1/Page2 Title</a></li>
          <li><a href="/dir1/page1.html">dir1/Page1 Title</a></li>
      """
