require 'capybara/cucumber'
require 'rack/test'

module Capybara::RailsServer
  class Node < Capybara::RackTest::Node
  end

  class Form < Capybara::RackTest::Form
  end

  class Driver < Capybara::Driver::Base
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
      send(method, url, params)
    end

    def get(url, params = {})
      reset_url(url)
      query = Rack::Utils.build_nested_query(params)
      path_with_query = [@current_path, query].join('?')
      @current_response = RailsServer.get(path_with_query)
      follow_redirects
    end

    def post(url, params = {})
      reset_url(url)
      data = Rack::Utils.build_nested_query(params)
      @current_response = RailsServer.post(@current_path, data)
      follow_redirects
    end

    private

    def reset_url(url)
      @current_path = URI.parse(url).path
      @current_url = @base_url.merge(@current_path)
      @body = nil
      @html = nil
    end

    def html
      @html ||= Nokogiri::HTML.parse(body)
    end

    def follow_redirects
      5.times do
        follow_redirect if redirect?
      end
      raise Capybara::InfiniteRedirectError, "redirected more than 5 times, check for infinite redirects." if redirect?
    end

    def follow_redirect
      get(@current_response["location"])
    end

    def redirect?
      Net::HTTPRedirection === @current_response
    end
  end
end

Capybara.register_driver :rails_server do |app|
  Capybara::RailsServer::Driver.new(app)
end

Capybara.default_selector = :css
Capybara.save_and_open_page_path = 'tmp/capybara'
Capybara.run_server = false
Capybara.default_driver = :rails_server
