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

    def input(input_name)
      Input.new(:name   => input_name,
                :prefix => name,
                :value  => target.send(input_name))
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

    def name
      target.class.model_name.singular
    end

    def to_key
      target.to_key
    end

    private

    def persisted?
      target.persisted?
    end

    attr_reader :controller
  end
end

