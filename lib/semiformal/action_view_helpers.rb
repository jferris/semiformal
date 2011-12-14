require 'action_view'
require 'semiformal/renderer'
require 'semiformal/form'

module Semiformal
  module ActionViewHelpers
    def render_form(resource, &block)
      form = Form.new(self, resource)
      Renderer.new(self, form).render(&block)
    end
  end
end

ActionView::Base.class_eval do
  include Semiformal::ActionViewHelpers
end

