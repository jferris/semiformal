module Semiformal
  # Converts parameter and resource values to integers.
  class IntegerValue
    def initialize(raw_value)
      @integer_value = raw_value.to_i
    end

    def to_s
      @integer_value.to_s
    end

    def convert
      @integer_value
    end

    def set(new_value)
      self.class.new(new_value)
    end
  end
end
