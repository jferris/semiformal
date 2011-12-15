require 'spec_helper'
require 'semiformal/resource'
require 'semiformal/form'
require 'semiformal/renderer'
require 'action_view/base'
require 'action_view/template'

describe Semiformal::Renderer do
  include ModelBuilder

  let(:model_class) do
    define_model('Post') do
      attr_accessor :title
    end
  end

  let(:target) { model_class.new }
  let(:controller) { Controller.new }
  let(:resource) { Semiformal::Resource.new(target).accept(:title) }
  let(:form) { Semiformal::Form.new(controller, resource) }
  let(:buffer) {  ActionView::OutputBuffer.new }

  def capture(*args, &block)
    block.call(*args)
  end

  subject { Semiformal::Renderer.new(self, form) }

  it "renders the given form" do
    rendered = subject.render { "<span>inner</span>".html_safe }

    rendered.should have_css("form#new_post.post[action='/posts'][method='post']")
    rendered.should have_css("span:contains('inner')")
    rendered.should have_css("input[type=hidden][name=_method][value=#{resource.method}]")
  end

  it "generates a list of inputs" do
    rendered = subject.inputs { "<li>inner</li>".html_safe }

    rendered.should have_css("fieldset.inputs ol li:contains('inner')")
  end

  it "generates an input" do
    rendered = subject.input(:title)

    rendered.should have_css("li input[type=text][name='post[title]'][id=post_title]")
    rendered.should have_css("li label[for=post_title]:contains('Title')")
    rendered.should have_css("li input[type=text][name='post[title]'][id=post_title]")
  end

  it "generates an input with a nil value" do
    target.title = nil
    rendered = subject.input(:title)
    rendered.should have_css("input[id=post_title][value='']")
  end

  it "generates an input with an empty value" do
    target.title = ""
    rendered = subject.input(:title)
    rendered.should have_css("input[id=post_title][value='']")
  end

  it "generates an input with a value" do
    target.title = "Hello"
    rendered = subject.input(:title)
    rendered.should have_css("input[id=post_title][value='Hello']")
  end

  it "generates a list of buttons" do
    rendered = subject.buttons { "<li>inner</li>".html_safe }

    rendered.should have_css("fieldset.buttons ol li:contains('inner')")
  end

  it "generates a commit button" do
    rendered = subject.commit_button

    rendered.should have_css("input[type=submit][name=commit][value='Create Post']")
  end
end

