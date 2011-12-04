require 'semiformal/input'

module Semiformal
  # Defines accepted parameters, conversions, and generated input names for
  # an HTTP resource.
  class Resource
    attr_reader :target

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

    def input(name)
      Input.new(:name   => name,
                :prefix => param_name,
                :value  => target.send(name))
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

    attr_reader :controller

    def param_name
      name.singular
    end

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

