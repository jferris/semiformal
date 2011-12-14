module Semiformal
  # Converts parameter and resource values to text.
  class TextValue
    def initialize(value)
      @value = value
    end

    def to_s
      @value.to_s
    end

    def ==(other)
      to_s == other.to_s
    end
  end
end
