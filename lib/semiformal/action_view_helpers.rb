require 'action_view'
require 'semiformal/form'

module Semiformal
  module ActionViewHelpers
    def render_form(form, &block)
      output = tag(:form, form.default_attributes, true)
      output << capture(form, &block)
      output.safe_concat('</form>')
    end
  end
end

module ActionView
  class Base
    include Semiformal::ActionViewHelpers
  end
end

