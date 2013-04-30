require 'active_model'

class Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def initialize(id = nil)
    @id = id
  end

  def persisted?
    @id.present?
  end

  def persist
    @id = 1
  end

  def unpersist
    @id = nil
  end

  def to_key
    if persisted?
      [@id]
    else
      nil
    end
  end
end

module ModelBuilder
  extend ActiveSupport::Concern

  included do
    before { @defined_constants = [] }
    after { undefine_constants }
  end

  def define_model(name, &block)
    model_class = define_class(name, Model, &block)
  end

  def define_class(name, superclass, &block)
    @defined_constants << name
    Class.new(superclass).tap do |defined_class|
      defined_class.class_eval(&block) if block
      Object.const_set(name, defined_class)
    end
  end

  def undefine_constants
    @defined_constants.each do |defined_constant|
      Object.send(:remove_const, defined_constant)
    end
  end
end

