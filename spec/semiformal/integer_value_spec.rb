require 'spec_helper'
require 'semiformal/integer_value'

describe Semiformal::IntegerValue do
  it "converts #to_s" do
    Semiformal::IntegerValue.new("52").to_s.should == "52"
  end

  it "converts #to_i" do
    Semiformal::IntegerValue.new("52").to_i.should == 52
  end

  it "converts #to_a" do
    Semiformal::IntegerValue.new(52).to_a.should == %w(52)
  end

  it "can #set a value" do
    Semiformal::IntegerValue.new("52").set("38").to_s.should == "38"
  end

  it "can #convert a value" do
    Semiformal::IntegerValue.new("52").convert.should == 52
  end

  it "is #== with the same numeric value" do
    Semiformal::IntegerValue.new("52").should == Semiformal::IntegerValue.new(52)
  end

  it "isn't #== with a different numeric value" do
    Semiformal::IntegerValue.new(52).should_not == Semiformal::IntegerValue.new(51)
  end
end
