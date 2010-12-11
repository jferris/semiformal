require 'capybara/cucumber'

class Capybara::Driver::RailsServer < Capybara::Driver::Base
  class Node < Capybara::Driver::RackTest::Node
  end

  class Form < Capybara::Driver::RackTest::Form
  end

  def initialize(ignored_app)
    @base_url = URI.parse(RailsServer.app_host)
  end

  def current_url
    @current_url
  end

  def visit(path)
    get(path)
  end

  def find(query)
    html.xpath(query).map { |node| Node.new(self, node) }
  end

  def source
    body
  end

  def body
    @body ||= @current_response.body
  end

  def submit(method, url, params)
    path = URI.parse(url).path
    send(method, path, params)
  end

  def get(path, params = {})
    reset_url(path)
    query = Rack::Utils.build_nested_query(params)
    path_with_query = [path, query].join('?')
    @current_response = RailsServer.get(path_with_query)
  end

  def post(path, params = {})
    reset_url(path)
    data = Rack::Utils.build_nested_query(params)
    @current_response = RailsServer.post(path, data)
  end

  private

  def reset_url(path)
    @current_url = @base_url.merge(path)
    @body = nil
    @html = nil
  end

  def html
    @html ||= Nokogiri::HTML.parse(body)
  end
end

Capybara.register_driver :rails_server do |app|
  Capybara::Driver::RailsServer.new(app)
end

Capybara.default_selector = :css
Capybara.save_and_open_page_path = 'tmp/capybara'
Capybara.run_server = false
Capybara.default_driver = :rails_server


