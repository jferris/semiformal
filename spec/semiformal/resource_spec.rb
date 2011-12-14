require 'spec_helper'
require 'semiformal/resource'

describe Semiformal::Resource do
  include ModelBuilder

  let(:model_class) do
    define_model('Post') do
      attr_accessor :title
      attr_accessor :to_key
    end
  end

  let(:model) { model_class.new }
  let(:resource) { Semiformal::Resource.new(model) }
  subject { resource }

  it "has a #name" do
    subject.name.should == "post"
  end

  it "delegates #to_key" do
    model.to_key = "expected"
    resource.to_key.should == "expected"
  end

  it "uses the model as the default #url_target" do
    subject.url_target.should == model
  end

  it "uses post for an unpersisted model" do
    model.unpersist
    subject.method.should == 'post'
  end

  it "uses put for a persisted model" do
    model.persist
    subject.method.should == 'put'
  end

  context "input" do
    let(:name) { 'title' }
    subject { resource.input(name) }

    it "returns an input with that name" do
      should be_a(Semiformal::Input)
      subject.name.should == name
    end

    it "prefixes input names" do
      subject.param_name.should == 'post[title]'
    end

    it "sets the value" do
      model.title = "Hello"
      subject.to_s.should == "Hello"
    end
  end
end

