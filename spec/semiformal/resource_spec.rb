require 'spec_helper'
require 'semiformal/resource'

describe Semiformal::Resource do
  include ModelBuilder

  it "has a #name" do
    build_resource('Post').name.should == "post"
  end

  it "delegates #to_key" do
    resource = build_resource do
      def to_key
        "expected"
      end
    end
    resource.to_key.should == "expected"
  end

  it "uses the model as the #url_target" do
    model = build_model
    Semiformal::Resource.new(model).url_target.should == model
  end

  it "uses post as the #method for an unpersisted model" do
    resource = build_resource do
      def persisted?
        false
      end
    end
    resource.method.should == 'post'
  end

  it "uses put as the #method for a persisted model" do
    resource = build_resource do
      def persisted?
        true
      end
    end
    resource.method.should == 'put'
  end

  it "returns an #input it should #accept" do
    resource = build_resource {
      def title
        "example"
      end
    }.accept(:title)
    input = resource.input(:title)
    input.should be_a(Semiformal::Input)
    input.name.should == :title
    input.param_name.should == 'post[title]'
    input.to_s.should == "example"
  end

  it "won't generate an #input it shouldn't #accept" do
    resource = build_resource_accepting(:title)
    expect { resource.input(:name) }.to raise_error(Semiformal::UnacceptableInput, /name/)
  end

  it "can #parse a string parameter that it should #accept" do
    resource = build_resource_accepting(:title)
    resource.parse(:title => :hello).should == { :title => "hello" }
  end

  it "will #parse the string key for a parameter it should #accept" do
    resource = build_resource_accepting(:title)
    resource.parse("title" => :hello).should == { "title" => "hello" }
  end

  it "will #parse a symbolic key for a parameter specified with a string name" do
    resource = build_resource_accepting("title")
    resource.parse(:title => :hello).should == { :title => "hello" }
  end

  it "won't #parse a string parameter that it shouldn't #accept" do
    resource = build_resource_accepting(:name)
    expect { resource.parse(:title => "hello") }.to raise_error(Semiformal::UnacceptableInput, /title/)
  end

  it "doesn't mutate when told about an input it should #accept" do
    original_resource = build_resource { attr_reader :name }
    modified_resource = original_resource.accept(:name)
    expect { modified_resource.parse(:name => nil) }.not_to raise_error
    expect { original_resource.parse(:name => nil) }.to raise_error(Semiformal::UnacceptableInput)
  end

  it "can #parse an explicit string parameter" do
    resource = build_resource {
      attr_reader :name
    }.accept(:name, :as => :string)
    resource.parse(:name => :bill).should == { :name => "bill" }
  end

  it "can #parse an integer parameter" do
    resource = build_resource {
      attr_reader :age
    }.accept(:age, :as => :integer)
    resource.parse(:age => "52").should == { :age => 52 }
  end

  it "can #parse an array parameter" do
    resource = build_resource {
      attr_reader :colors
    }.accept(:colors, :as => :array)
    resource.parse(:colors => [1, 2, 3]).should == { :colors => [1, 2, 3] }
  end

  def build_model(name = 'Post', &block)
    define_model(name, &block).new
  end

  def build_resource(name = 'Post', &block)
    Semiformal::Resource.new(build_model(name, &block))
  end

  def build_resource_accepting(*inputs)
    model = define_model('Post') do
      inputs.each { |input| attr_reader input }
    end
    resource = Semiformal::Resource.new(model.new)
    inputs.inject(resource) do |result, input|
      resource.accept(input)
    end
  end
end

