module Semiformal
  # Converts parameter and resource values to text.
  class TextValue
    def initialize(raw_value)
      @string_value = raw_value.to_s
    end

    def self.accept?(raw_value)
      true
    end

    def to_s
      @string_value
    end

    def to_i
      @string_value.to_i
    end

    def to_a
      @string_value.split(",").map(&:strip)
    end

    def convert
      @string_value
    end

    def set(new_value)
      self.class.new(new_value)
    end

    def ==(other)
      to_s == other.to_s
    end
  end
end
