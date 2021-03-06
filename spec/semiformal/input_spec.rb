require 'spec_helper'
require 'semiformal/input'
require 'semiformal/text_value'
require 'semiformal/integer_value'

describe Semiformal::Input do
  it "has a #name" do
    build_input(:name => "email").name.should == "email"
  end

  it "has a #param_name" do
    build_input(:prefix => "user", :name => "address").param_name.should == "user[address]"
  end

  it "has an #html_id" do
    build_input(:prefix => "user", :name => "address").html_id.should == "user_address"
  end

  it "has a #to_s" do
    build_input(:value => 10).to_s.should == "10"
  end

  it "is #== with the same name, prefix, and value" do
    build_input(:name => "name", :prefix => "prefix", :value => "value").
      should == build_input(:name => "name", :prefix => "prefix", :value => "value")
  end

  it "isn't #== with the same name and prefix but a different value" do
    build_input(:name => "name", :prefix => "prefix", :value => "value").
      should_not == build_input(:name => "name", :prefix => "prefix", :value => "other value")
  end

  it "isn't #== with the same prefix and value but a different name" do
    build_input(:name => "name", :prefix => "prefix", :value => "value").
      should_not == build_input(:name => "other name", :prefix => "prefix", :value => "value")
  end

  it "isn't #== with the same name and value but a different prefix" do
    build_input(:name => "name", :prefix => "prefix", :value => "value").
      should_not == build_input(:name => "name", :prefix => "other prefix", :value => "value")
  end

  it "can #convert a value" do
    build_input(:value => Semiformal::TextValue.new('whatever')).convert(52).should == "52"
    build_input(:value => Semiformal::IntegerValue.new('whatever')).convert("52").should == 52
  end

  def build_input(attributes = {})
    Semiformal::Input.new({
      :name   => 'title',
      :prefix => 'post',
      :value  => 'any value'
    }.update(attributes))
  end
end
