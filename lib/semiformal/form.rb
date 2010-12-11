require 'semiformal/attribute'

module Semiformal
  # Defines accepted parameters, conversions, and generated attribute names for
  # an html form.
  class Form
    attr_reader :controller, :target

    def initialize(controller, target)
      @controller = controller
      @target = target
    end

    def url
      target
    end

    def default_attributes
      { 'class'  => html_class,
        'id'     => html_id,
        'action' => html_action,
        'method' => 'post' }
    end

    def attribute(name)
      Attribute.new(:name   => name,
                    :prefix => param_name)
    end

    def html_id
      controller.dom_id(target)
    end

    def param_name
      target.class.model_name.singular
    end

    private

    def html_class
      controller.dom_class(target)
    end

    def html_action
      controller.url_for(url)
    end
  end
end

