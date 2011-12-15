require 'semiformal/input'
require 'semiformal/text_value'
require 'semiformal/unacceptable_input'

module Semiformal
  # Defines accepted parameters, conversions, and generated input names for
  # an HTTP resource.
  class Resource
    def initialize(model, options = {})
      @model = model
      @inputs = options[:inputs] || []
    end

    def method
      if persisted?
        'put'
      else
        'post'
      end
    end

    def url_target
      model
    end

    def name
      model.class.model_name.singular
    end

    def to_key
      model.to_key
    end

    def input(input_name)
      ensure_acceptable(input_name)
      Input.new(:name   => input_name,
                :prefix => name,
                :value  => TextValue.new(model.send(input_name)))
    end

    def accept(name)
      self.class.new(@model, :inputs => @inputs + [name.to_sym])
    end

    def parse(params)
      params.inject({}) do |result, (name, value)|
        ensure_acceptable(name)
        result.update(name => value.to_s)
      end
    end

    def ensure_acceptable(name)
      unless @inputs.include?(name.to_sym)
        raise UnacceptableInput, "no such input: #{name}"
      end
    end

    private

    def persisted?
      model.persisted?
    end

    attr_reader :model
  end
end

