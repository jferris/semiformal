require 'action_view'

module Semiformal
  # Generates HTML for a Form.
  class Renderer
    attr_reader :form

    def initialize(captureable, form)
      @captureable = captureable
      @form = form
    end

    def render(&block)
      method_input = tag(:input, :name  => '_method',
                                 :type  => 'hidden',
                                 :value => form.method)

      contents = method_input + capture(self, &block)
      content_tag(:form, contents, form.default_attributes)
    end

    def inputs(&block)
      contents = capture(&block)
      fields = content_tag(:ol, contents)
      content_tag(:fieldset, fields, :class => 'inputs')
    end

    def buttons(&block)
      contents = capture(&block)
      buttons = content_tag(:ol, contents)
      content_tag(:fieldset, buttons, :class => 'buttons')
    end

    def input(name)
      attribute = form.attribute(name)
      html_id = attribute.html_id
      label = content_tag(:label, name.to_s.titleize, :for => html_id)
      input = tag(:input, :type  => 'text',
                          :name  => attribute.param_name,
                          :value => attribute.string_value,
                          :id    => html_id)
      content_tag(:li, label + input)
    end

    def commit_button
      tag(:input, :type => 'submit', :name => 'commit', :value => form.commit_button_value)
    end

    private

    def capture(*args, &block)
      @captureable.capture(*args, &block)
    end

    include ActionView::Helpers::TagHelper
  end
end
