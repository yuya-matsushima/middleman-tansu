require 'aruba/api'
require 'aruba/cucumber/hooks'
require 'aruba/reporting'

Then /^the helper result "(.*?)" should (not )?contain '(.*?)'$/ do |file, expect_match, partial_content|
  check_file_content(file, Regexp.compile(Regexp.escape(partial_content)), !expect_match)
end
