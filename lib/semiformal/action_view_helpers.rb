require 'semiformal/form'

module Semiformal
  module ActionViewHelpers
    def render_form(form, &block)
      form_for(form.target, &block)
    end
  end
end

module ActionView
  class Base
    include Semiformal::ActionViewHelpers
  end
end

