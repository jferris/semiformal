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

  let(:target) { model_class.new }
  let(:controller) { Controller.new }
  let(:resource) { Semiformal::Resource.new(controller, target) }
  subject { resource }

  it "has a #name" do
    subject.name.should == "post"
  end

  it "delegates #to_key" do
    target.to_key = "expected"
    resource.to_key.should == "expected"
  end

  it "uses the target as the default url" do
    subject.url.should == controller.url_for(target)
  end

  it "uses post for an unpersisted target" do
    target.persisted = false
    subject.method.should == 'post'
  end

  it "uses put for a persisted target" do
    target.persisted = true
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
      target.title = "Hello"
      subject.to_s.should == "Hello"
    end
  end
end

