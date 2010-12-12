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

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |label, value|
  fill_in label, :with => value
end

Then /^the "([^"]*)" field should contain "([^"]*)"$/ do |label, value|
  find_field(label).value.should == value
end

