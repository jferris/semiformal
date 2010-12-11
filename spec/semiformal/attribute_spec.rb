require 'spec_helper'
require 'semiformal/attribute'

describe Semiformal::Attribute do
  let(:prefix) { 'post' }
  let(:name) { 'title' }
  subject { Semiformal::Attribute.new(:name   => name,
                                      :prefix => prefix) }

  it "has a name" do
    subject.name.should == name
  end

  it "has a param name" do
    subject.param_name.should == "post[title]"
  end

  it "has an html id" do
    subject.html_id.should == "post_title"
  end
end
