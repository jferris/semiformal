require 'action_view'

module Semiformal
  # Generates HTML for a Resource.
  class Renderer
    def initialize(captureable, resource)
      @captureable = captureable
      @resource = resource
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
      attribute = resource.attribute(name)
      html_id = attribute.html_id
      label = content_tag(:label, name.to_s.titleize, :for => html_id)
      input = tag(:input, :type  => 'text',
                          :name  => attribute.param_name,
                          :value => attribute.string_value,
                          :id    => html_id)
      content_tag(:li, label + input)
    end

    def commit_button
      tag(:input, :type => 'submit', :name => 'commit', :value => resource.commit_button_value)
    end

    private

    attr_reader :resource

    def capture(*args, &block)
      @captureable.capture(*args, &block)
    end

    def form_method
      resource.method
    end

    def default_form_attributes
      resource.default_attributes
    end

    include ActionView::Helpers::TagHelper
  end
end
