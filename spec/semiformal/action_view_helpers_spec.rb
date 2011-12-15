require 'spec_helper'
require 'semiformal/action_view_helpers'
require 'semiformal/resource'

describe Semiformal::ActionViewHelpers do
  include ModelBuilder

  let(:target) { define_model("Post").new }
  let(:resource) { Semiformal::Resource.new(target).accept(:object_id) }

  def render(template)
    view = ActionView::Base.new
    def view.posts_path
      "/posts"
    end
    view.render(:inline => template, :locals => { :resource => resource })
  end

  it "yields a renderer for the resource and returns the result" do
    rendered = render %{
      <%= render_form resource do |form| -%>
        <span class="class_name"><%= form.class.name %></span>
        <%= form.input :object_id %>
      <% end -%>
    }

    rendered.should have_css("form .class_name:contains('Renderer')")
    rendered.should have_css("form input[value='#{target.object_id}']")
  end
end

