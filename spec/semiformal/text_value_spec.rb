require 'spec_helper'
require 'semiformal/text_value'

describe Semiformal::TextValue do
  it "converts #to_s" do
    Semiformal::TextValue.new(:value).to_s.should == "value"
  end

  it "converts #to_i" do
    Semiformal::TextValue.new("15").to_i.should == 15
  end

  it "converts #to_a" do
    Semiformal::TextValue.new("One,  two,three").to_a.should == %w(One two three)
  end

  it "can #set a value" do
    Semiformal::TextValue.new(:value).set(:new_value).should == "new_value"
  end

  it "can #convert a value" do
    Semiformal::TextValue.new(:value).convert.should == "value"
  end

  it "is #== with the same value" do
    Semiformal::TextValue.new("test").should == Semiformal::TextValue.new("test")
  end

  it "isn't #== with a different value" do
    Semiformal::TextValue.new("test").should_not == Semiformal::TextValue.new("other")
  end
end
