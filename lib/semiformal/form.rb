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

    def default_attributes
      { 'class'  => html_class,
        'id'     => html_id,
        'action' => url,
        'method' => 'post' }
    end

    def attribute(name)
      Attribute.new(:name   => name,
                    :prefix => param_name,
                    :value  => target.send(name))
    end

    def param_name
      name.singular
    end

    def commit_button_value
      commit_action = persisted? ? 'Update' : 'Create'
      "#{commit_action} #{name.human}"
    end

    def persisted?
      target.persisted?
    end

    def method
      if persisted?
        'put'
      else
        'post'
      end
    end

    def url
      controller.url_for(target)
    end

    private

    def html_id
      controller.dom_id(target)
    end

    def html_class
      controller.dom_class(target)
    end

    def name
      target.class.model_name
    end
  end
end

