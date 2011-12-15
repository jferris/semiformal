require 'spec_helper'
require 'semiformal/converter'

describe Semiformal::Converter do
  it "can #convert to a string" do
    Semiformal::Converter.new.convert(5, :as => :string).
      should == Semiformal::TextValue.new(5)
  end

  it "can #convert to an integer" do
    Semiformal::Converter.new.convert("5", :as => :integer).
      should == Semiformal::IntegerValue.new("5")
  end

  it "can #convert to an array" do
    Semiformal::Converter.new.convert(1..3, :as => :array).
      should == Semiformal::ArrayValue.new(1..3)
  end
end
