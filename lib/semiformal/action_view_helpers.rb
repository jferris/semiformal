require 'action_view'
require 'semiformal/form'
require 'semiformal/renderer'

module Semiformal
  module ActionViewHelpers
    def render_form(form, &block)
      Renderer.new(self, form).render(&block)
    end
  end
end

module ActionView
  class Base
    include Semiformal::ActionViewHelpers
  end
end

