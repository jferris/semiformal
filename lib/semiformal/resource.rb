require 'semiformal/input'
require 'semiformal/text_value'

module Semiformal
  # Defines accepted parameters, conversions, and generated input names for
  # an HTTP resource.
  class Resource
    def initialize(controller, target)
      @controller = controller
      @target = target
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

    def input(input_name)
      Input.new(:name   => input_name,
                :prefix => name,
                :value  => TextValue.new(target.send(input_name)))
    end

    private

    def persisted?
      target.persisted?
    end

    attr_reader :controller, :target
  end
end

