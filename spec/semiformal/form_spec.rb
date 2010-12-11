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

  context "default attributes" do
    subject { form.default_attributes }

    it "sets the class" do
      subject['class'].should == controller.dom_class(target)
    end

    it "sets the id" do
      subject['id'].should == controller.dom_id(target)
    end

    it "sets the action" do
      subject['action'].should == controller.url_for(form.url)
    end

    it "sets the method" do
      subject['method'].should == "post"
    end
  end
end

