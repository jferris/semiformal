require 'spec_helper'
require 'semiformal/action_view_helpers'

describe Semiformal::ActionViewHelpers do
  let(:target) { Model.new }
  let(:controller) { Controller.new }
  let(:form) { Semiformal::Form.new(controller, target) }

  def render(template)
    view = ActionView::Base.new
    view.render(:inline => template, :locals => { :form => form })
  end

  it "yields a renderer for the form and returns the result" do
    rendered = render %{
      <%= render_form form do |form| -%>
        <span class="class_name"><%= form.class.name %></span>
        <%= form.input :object_id %>
      <% end -%>
    }

    rendered.should have_css("form .class_name:contains('Renderer')")
    rendered.should have_css("form input[value='#{target.object_id}']")
  end
end

