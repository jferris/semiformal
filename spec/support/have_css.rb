require 'capybara'

RSpec::Matchers.define :have_css do |selector|
  match do |html|
    @html = html
    app = lambda { |env| [200, { 'Content-Type' => 'html' }, [html]] }
    session = Capybara::Session.new(:rack_test, app)
    session.visit('/')
    session.has_css?(selector)
  end

  failure_message_for_should do
    "Expected selector: #{selector}\nGot HTML:\n#{@html}"
  end

  failure_message_for_should_not do
    "Didn't expect selector: #{selector}\nGot HTML:\n#{@html}"
  end
end

