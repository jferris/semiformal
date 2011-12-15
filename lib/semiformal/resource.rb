require 'semiformal/input'
require 'semiformal/text_value'
require 'semiformal/integer_value'
require 'semiformal/array_value'
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
      find_input input_name
    end

    def accept(input_name, options = {})
      raw_value = model.send(input_name)
      if options[:as] == :integer
        value = IntegerValue.new(raw_value)
      elsif options[:as] == :array
        value = ArrayValue.new(raw_value)
      else
        value = TextValue.new(raw_value)
      end
      input = Input.new(:name => input_name.to_sym, :prefix => name, :value => value)
      self.class.new(@model, :inputs => @inputs + [input])
    end

    def parse(params)
      params.inject({}) do |result, (name, value)|
        result.update name => find_input(name).convert(value)
      end
    end

    private

    def find_input(name)
      @inputs.detect { |input| input.name == name.to_sym } or
        raise UnacceptableInput, "no such input: #{name}"
    end

    def persisted?
      model.persisted?
    end

    attr_reader :model
  end
end

