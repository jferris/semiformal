require 'spec_helper'
require 'semiformal/form'
require 'semiformal/resource'

describe Semiformal::Form do
  include ModelBuilder

  it "defines #default_attributes for an html put resource" do
    form_for(
      :method     => "put",
      :name       => "test_model",
      :url_target => build_model("User", 1),
      :to_key     => ["1"]
    ).
    default_attributes.should == {
      'method' => 'post',
      'class'  => 'test_model',
      'action' => '/users/1',
      "id"     => "edit_test_model_1"
    }
  end

  it "defines #default_attributes for an html post resource" do
    form_for(
      :method     => "post",
      :name       => "test_model",
      :url_target => build_model("User", nil),
      :to_key     => nil
    ).
    default_attributes.should == {
      'method' => 'post',
      'class'  => 'test_model',
      'action' => "/users",
      "id"     => "new_test_model"
    }
  end

  it "generates #commit_button_value for a post resource" do
    form_for(:method => "post", :name => "test_model").commit_button_value.should == "Create Test Model"
  end

  it "generates #commit_button_value for a put resource" do
    form_for(:method => "put", :name => "test_model").commit_button_value.should == "Update Test Model"
  end

  it "delegates #input to the resource" do
    model = define_model("TestModel") do
      attr_reader :name
    end
    resource = Semiformal::Resource.new(model.new).accept(:name)
    form = Semiformal::Form.new(Controller.new, resource)
    result = form.input(:name)
    result.should == resource.input(:name)
  end

  it "delegates #method to the resource" do
    form_for(:method => "post").method.should == "post"
  end

  it "delegates #url_target to the resource" do
    form_for(:url_target => "/happy_time").url_target.should == "/happy_time"
  end

  it "generates a #url from the url target" do
    form_for(:url_target => build_model("Post", 5)).url.should == "/posts/5"
  end

  it "delegates #to_key to the resource" do
    form_for(:to_key => ["happy"]).to_key.should == ["happy"]
  end

  it "delegates #name to the resource" do
    form_for(:name => "happy").name.should == "happy"
  end

  def form_for(attributes = {})
    Semiformal::Form.new(Controller.new, stub_resource(attributes))
  end

  def stub_resource(attributes = {})
    stub("resource", attributes)
  end

  def build_model(name, id)
    define_model(name).new(id)
  end
end
