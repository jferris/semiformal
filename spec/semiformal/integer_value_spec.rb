require 'spec_helper'
require 'semiformal/integer_value'

describe Semiformal::IntegerValue do
  it "converts #to_s" do
    Semiformal::IntegerValue.new("52").to_s.should == "52"
  end

  it "can #set a value" do
    Semiformal::IntegerValue.new("52").set("38").to_s.should == "38"
  end

  it "can #convert a value" do
    Semiformal::IntegerValue.new("52").convert.should == 52
  end
end
