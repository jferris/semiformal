When /^I visit (.*)$/ do |path|
  visit path
end

When /^I press "([^"]*)"$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |content|
  page.should have_content(content)
end

Then /^show me the page$/ do
  save_and_open_page
end
