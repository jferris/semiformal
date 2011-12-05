require 'action_view'

module Semiformal
  # Generates HTML for a Form.
  class Renderer
    def initialize(captureable, form)
      @captureable = captureable
      @form = form
    end

    def render(&block)
      method_input = tag(:input, :name  => '_method',
                                 :type  => 'hidden',
                                 :value => form_method)

      contents = method_input + capture(self, &block)
      content_tag(:form, contents, default_form_attributes)
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
      input = form.input(name)
      html_id = input.html_id
      label = content_tag(:label, name.to_s.titleize, :for => html_id)
      input_html = tag(:input, :type  => 'text',
                               :name  => input.param_name,
                               :value => input.string_value,
                               :id    => html_id)
      content_tag(:li, label + input_html)
    end

    def commit_button
      tag(:input, :type => 'submit', :name => 'commit', :value => form.commit_button_value)
    end

    private

    attr_reader :form

    def capture(*args, &block)
      @captureable.capture(*args, &block)
    end

    def form_method
      form.method
    end

    def default_form_attributes
      form.default_attributes
    end

    include ActionView::Helpers::TagHelper
  end
end
