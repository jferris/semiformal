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
      { 'class'  => name,
        'id'     => html_id,
        'action' => url,
        'method' => 'post' }
    end

    def input(input_name)
      Input.new(:name   => input_name,
                :prefix => name,
                :value  => target.send(input_name))
    end

    def commit_button_value
      commit_action = persisted? ? 'Update' : 'Create'
      "#{commit_action} #{name.humanize}"
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

    def name
      target.class.model_name.singular
    end

    def html_id
      controller.dom_id(target)
    end
  end
end

