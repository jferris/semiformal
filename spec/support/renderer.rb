require 'capybara'

class Renderer
  module Helpers
    def models_path
      '/models'
    end

    def protect_against_forgery?
      false
    end
  end

  def initialize
    @view = ActionView::Base.new
    @view.extend(Helpers)
  end

  def render(string, assigns = {})
    body = @view.render(:inline => string, :locals => assigns)
    app = lambda { |env| [200, { 'Content-Type' => 'html' }, [body]] }
    @session = Capybara::Session.new(:rack_test, app)
    @session.visit('/')
    self
  end

  def rendered
    @session
  end

  def self.render(string, assigns = {})
    new.render(string, assigns).rendered
  end
end

