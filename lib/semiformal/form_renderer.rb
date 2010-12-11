require 'action_view'

module Semiformal
  class FormRenderer
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
      label = content_tag(:label, name.to_s.titleize, :for => "#{form.target.class.name.underscore}_#{name}")
      input = tag(:input, :type => 'text', :name => "#{form.target.class.name.underscore}[#{name}]", :id => "#{form.target.class.name.underscore}_#{name}")
      content_tag(:li, label + input)
    end

    private

    def capture(*args, &block)
      @captureable.capture(*args, &block)
    end

    include ActionView::Helpers::TagHelper
  end
end
