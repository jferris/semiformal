require 'spec_helper'
require 'semiformal/form'
require 'semiformal/renderer'
require 'action_view/base'
require 'action_view/template'

describe Semiformal::Renderer do
  let(:target) { Model.new }
  let(:controller) { Controller.new }
  let(:form) { Semiformal::Form.new(controller, target) }
  let(:buffer) {  ActionView::OutputBuffer.new }

  def capture(*args, &block)
    block.call(*args)
  end

  subject { Semiformal::Renderer.new(self, form) }

  it "returns the form" do
    subject.form.should == form
  end

  it "renders the given form" do
    rendered = subject.render { "<span>inner</span>".html_safe }

    rendered.should have_css("form#new_model.model[action='/models'][method='post']")
    rendered.should have_css("span:contains('inner')")
  end

  it "generates a list of inputs" do
    rendered = subject.inputs { "<li>inner</li>".html_safe }

    rendered.should have_css("fieldset.inputs ol li:contains('inner')")
  end

  it "generates an input" do
    rendered = subject.input(:title)

    rendered.should have_css("li input[type=text][name='model[title]'][id=model_title]")
    rendered.should have_css("li label[for=model_title]:contains('Title')")
  end

  it "generates a list of buttons" do
    rendered = subject.buttons { "<li>inner</li>".html_safe }

    rendered.should have_css("fieldset.buttons ol li:contains('inner')")
  end

  it "generates a commit button" do
    rendered = subject.commit_button

    rendered.should have_css("input[type=submit][name=commit][value='Create Model']")
  end
end

