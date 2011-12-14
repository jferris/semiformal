require 'semiformal/input'
require 'semiformal/text_value'

module Semiformal
  # Defines accepted parameters, conversions, and generated input names for
  # an HTTP resource.
  class Resource
    def initialize(controller, model)
      @controller = controller
      @model = model
    end

    def method
      if persisted?
        'put'
      else
        'post'
      end
    end

    def url
      controller.url_for(model)
    end

    def name
      model.class.model_name.singular
    end

    def to_key
      model.to_key
    end

    def input(input_name)
      Input.new(:name   => input_name,
                :prefix => name,
                :value  => TextValue.new(model.send(input_name)))
    end

    private

    def persisted?
      model.persisted?
    end

    attr_reader :controller, :model
  end
end

