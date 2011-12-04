require 'spec_helper'
require 'semiformal/input'

describe Semiformal::Input do
  let(:prefix) { 'post' }
  let(:name) { 'title' }
  let(:value) { 'any value' }
  subject { Semiformal::Input.new(:name   => name,
                                  :prefix => prefix,
                                  :value  => value) }

  it "has a name" do
    subject.name.should == name
  end

  it "has a param name" do
    subject.param_name.should == "post[title]"
  end

  it "has an html id" do
    subject.html_id.should == "post_title"
  end

  it "has a string value" do
    subject.string_value.should == value
  end
end
