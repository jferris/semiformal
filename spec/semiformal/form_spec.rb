require 'spec_helper'
require 'semiformal/form'

describe Semiformal::Form do
  let(:target) { Model.new }
  let(:controller) { Controller.new }
  let(:form) { Semiformal::Form.new(controller, target) }
  subject { form }

  it "has a target" do
    subject.target.should == target
  end

  it "uses the target as the default url" do
    subject.url.should == target
  end

  it "has an html id" do
    subject.html_id.should == controller.dom_id(target)
  end

  it "has a param name" do
    subject.param_name.should == 'model'
  end

  it "has a commit button value" do
    subject.commit_button_value.should == "Create Model"
  end

  context "default attributes" do
    subject { form.default_attributes }

    it "sets the class" do
      subject['class'].should == controller.dom_class(target)
    end

    it "sets the id" do
      subject['id'].should == form.html_id
    end

    it "sets the action" do
      subject['action'].should == controller.url_for(form.url)
    end

    it "sets the method" do
      subject['method'].should == "post"
    end
  end

  context "attribute" do
    let(:name) { 'title' }
    subject { form.attribute(name) }

    it "returns an attribute with that name" do
      should be_a(Semiformal::Attribute)
      subject.name.should == name
    end
  end
end

