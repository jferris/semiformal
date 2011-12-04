module Semiformal
  # An attribute for a resource.
  #
  # Generates default html attributes for a given resource attribute.
  class Attribute
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

    def string_value
      @value.to_s
    end
  end
end
