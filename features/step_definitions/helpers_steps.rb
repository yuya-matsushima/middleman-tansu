require 'aruba/api'
require 'aruba/cucumber/hooks'
require 'aruba/reporting'

Given /^I set the timezone to "(.*?)"$/ do |zone|
  set_env("TZ", zone.to_s)
end

Then /^the helper result "(.*?)" should (not )?contain '(.*?)'$/ do |file, expect_match, partial_content|
  check_file_content(file, Regexp.compile(Regexp.escape(partial_content)), !expect_match)
end

Then /^the helper result "(.*?)" should (not )?contain:$/ do |file, expect_match, partial_content|
  check_file_content(file, Regexp.compile(Regexp.escape(partial_content)), !expect_match)
end
