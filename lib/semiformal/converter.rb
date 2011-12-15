require 'semiformal/text_value'
require 'semiformal/integer_value'
require 'semiformal/array_value'

module Semiformal
  # Determines how to convert values based on requested and actual types.
  class Converter
    def initialize
      @value_factories = {
        :integer => IntegerValue,
        :array => ArrayValue,
        :string => TextValue
      }
    end

    def convert(raw_value, options)
      @value_factories[options[:as]].new(raw_value)
    end

    def guess(raw_value)
      factory = @value_factories.values.detect do |factory|
        factory.accept?(raw_value)
      end
      factory.new(raw_value)
    end
  end
end
