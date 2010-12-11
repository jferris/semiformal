module Semiformal
  # An attribute for a form.
  #
  # Generates default html attributes for a given form attribute.
  class Attribute
    attr_reader :name

    def initialize(arguments)
      @name   = arguments[:name]
      @prefix = arguments[:prefix]
    end

    def param_name
      "#{@prefix}[#{name}]"
    end

    def html_id
      "#{@prefix}_#{name}"
    end
  end
end
