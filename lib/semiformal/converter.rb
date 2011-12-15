require 'semiformal/text_value'
require 'semiformal/integer_value'
require 'semiformal/array_value'

module Semiformal
  # Determines how to convert values based on requested and actual types.
  class Converter
    def convert(raw_value, options)
      case options[:as]
      when :integer
        IntegerValue.new(raw_value)
      when :array
        ArrayValue.new(raw_value)
      when :string
        TextValue.new(raw_value)
      end
    end
  end
end
