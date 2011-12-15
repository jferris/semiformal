module Semiformal
  # An input for a resource.
  #
  # Generates default html attributes for a given resource input.
  class Input
    attr_reader :name

    def initialize(arguments)
      @name   = arguments[:name]
      @prefix = arguments[:prefix]
      @value  = arguments[:value]
    end

    def param_name
      "#{@prefix}[#{name}]"
    end

    def html_id
      "#{@prefix}_#{name}"
    end

    def to_s
      @value.to_s
    end

    def ==(other)
      value == other.value && name == other.name && prefix == other.prefix
    end

    def convert(raw_value)
      @value.set(raw_value).convert
    end

    protected

    attr_reader :value, :prefix
  end
end
