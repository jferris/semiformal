require 'action_view'

module Semiformal
  class Renderer
    attr_reader :form

    def initialize(captureable, form)
      @captureable = captureable
      @form = form
    end

    def render(&block)
      contents = capture(self, &block)
      content_tag(:form, contents, form.default_attributes)
    end

    def inputs(&block)
      contents = capture(&block)
      fields = content_tag(:ol, contents)
      content_tag(:fieldset, fields, :class => 'inputs')
    end

    def input(name)
      attribute = form.attribute(name)
      label = content_tag(:label, name.to_s.titleize, :for => attribute.html_id)
      input = tag(:input, :type => 'text',
                          :name => attribute.param_name,
                          :id   => attribute.html_id)
      content_tag(:li, label + input)
    end

    private

    def capture(*args, &block)
      @captureable.capture(*args, &block)
    end

    include ActionView::Helpers::TagHelper
  end
end
