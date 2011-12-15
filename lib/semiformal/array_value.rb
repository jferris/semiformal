module Semiformal
  # Converts parameter and resource values to arrays.
  class ArrayValue
    def initialize(raw_value)
      @array_value = raw_value.to_a
    end

    def to_s
      @array_value.join(", ")
    end

    def to_a
      @array_value
    end

    def set(new_value)
      self.class.new(new_value)
    end

    def convert
      @array_value
    end

    def ==(other)
      to_a == other.to_a
    end
  end
end