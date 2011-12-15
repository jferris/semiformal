require 'spec_helper'
require 'semiformal/array_value'

describe Semiformal::ArrayValue do
  it "converts #to_s" do
    Semiformal::ArrayValue.new([1, 2, 3]).to_s.should == "1, 2, 3"
  end

  it "converts #to_a" do
    Semiformal::ArrayValue.new(1..2).to_a.should == [1, 2]
  end

  it "can #set a value" do
    Semiformal::ArrayValue.new([1]).set([2]).to_s.should == "2"
  end

  it "can #convert a value" do
    Semiformal::ArrayValue.new(1..3).convert.should == [1, 2, 3]
  end

  it "is #== with the same array value" do
    Semiformal::ArrayValue.new(1..3).should == Semiformal::ArrayValue.new(1..3)
  end

  it "isn't #== with a different array value" do
    Semiformal::ArrayValue.new(1..3).should_not == Semiformal::ArrayValue.new(1..4)
  end
end
