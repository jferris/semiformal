When /^I add the "([^"]*)" gem from this project as a dependency$/ do |gem_name|
  append_to_file('Gemfile', %{\ngem "#{gem_name}", :path => "#{PROJECT_ROOT}"})
end

When /^I disable Capybara Javascript emulation$/ do
  replace_in_file "features/support/env.rb",
                  %{require 'cucumber/rails/capybara_javascript_emulation'},
                  "# Disabled"
end

When /^I configure a global route$/ do
  steps %{
    When I write to "config/routes.rb" with:
      """
      Rails.application.routes.draw do
        match ':controller(/:action(/:id(.:format)))'
      end
      """
  }
end

module FileHelpers
  def replace_in_file(path, find, replace)
    in_current_dir do
      contents = IO.read(path)
      contents.sub!(find, replace)
      File.open(path, "w") { |file| file.write(contents) }
    end
  end
end

World(FileHelpers)

When /^I (GET|POST|PUT|DELETE) (.*)$/ do |verb, path|
  @response_body = RailsServer.send(verb.downcase, path)
  @response_doc = Nokogiri::HTML.parse(@response_body)
end

When "I start the application" do
  in_current_dir do
    RailsServer.start(ENV['RAILS_PORT'])
  end
end

After do
  RailsServer.stop
end

Then /^the response should have the following "([^"]*)" tag:$/ do |css, table|
  attributes = table.transpose.hashes.first
  tags = @response_doc.search(css)
  if tags.empty?
    raise "No tags matched #{css.inspect}; got response:\n#{@response_doc}"
  else
    raise "not implemented"
  end
end
