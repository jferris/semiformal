require 'spec_helper'
require 'semiformal/array_value'

describe Semiformal::ArrayValue do
  it "converts #to_s" do
    Semiformal::ArrayValue.new([1, 2, 3]).to_s.should == "1, 2, 3"
  end

  it "can #set a value" do
    Semiformal::ArrayValue.new([1]).set([2]).to_s.should == "2"
  end

  it "can #convert a value" do
    Semiformal::ArrayValue.new(1..3).convert.should == [1, 2, 3]
  end
end
