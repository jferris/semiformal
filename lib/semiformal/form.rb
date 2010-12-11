require 'semiformal/attribute'

module Semiformal
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
      { 'class'  => controller.dom_class(target),
        'id'     => html_id,
        'action' => controller.url_for(url),
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
  end
end

