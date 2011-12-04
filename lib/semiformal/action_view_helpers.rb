require 'action_view'
require 'semiformal/resource'
require 'semiformal/renderer'

module Semiformal
  module ActionViewHelpers
    def render_form(resource, &block)
      Renderer.new(self, resource).render(&block)
    end
  end
end

ActionView::Base.class_eval do
  include Semiformal::ActionViewHelpers
end

