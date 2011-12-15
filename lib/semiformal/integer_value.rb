module Semiformal
  # Converts parameter and resource values to integers.
  class IntegerValue
    def initialize(raw_value)
      @integer_value = raw_value.to_i
    end

    def to_s
      @integer_value.to_s
    end

    def to_i
      @integer_value
    end

    def to_a
      [@integer_value.to_s]
    end

    def convert
      @integer_value
    end

    def set(new_value)
      self.class.new(new_value)
    end

    def ==(other)
      to_i == other.to_i
    end
  end
end
