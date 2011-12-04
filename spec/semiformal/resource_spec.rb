require 'spec_helper'
require 'semiformal/resource'

describe Semiformal::Resource do
  include ModelBuilder

  let(:model_class) do
    define_model('Post') do
      attr_accessor :title
    end
  end

  let(:target) { model_class.new }
  let(:controller) { Controller.new }
  let(:resource) { Semiformal::Resource.new(controller, target) }
  subject { resource }

  it "has a target" do
    subject.target.should == target
  end

  it "uses the target as the default url" do
    subject.url.should == controller.url_for(target)
  end

  it "has a commit button value for a new record" do
    target.persisted = false
    subject.commit_button_value.should == "Create Post"
  end

  it "has a commit button value for a persisted record" do
    target.persisted = true
    subject.commit_button_value.should == "Update Post"
  end

  it "is persisted when its target is" do
    target.persisted = true
    subject.should be_persisted
  end

  it "isn't persisted when its target isn't" do
    target.persisted = false
    subject.should_not be_persisted
  end

  it "uses post for an unpersisted target" do
    target.persisted = false
    subject.method.should == 'post'
  end

  it "uses put for a persisted target" do
    target.persisted = true
    subject.method.should == 'put'
  end

  context "default attributes" do
    subject { resource.default_attributes }

    it "sets the class" do
      subject['class'].should == controller.dom_class(target)
    end

    it "sets the id" do
      subject['id'].should == controller.dom_id(target)
    end

    it "sets the action" do
      subject['action'].should == controller.url_for(target)
    end

    it "sets the method" do
      subject['method'].should == "post"
    end
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
      subject.string_value.should == "Hello"
    end
  end
end

