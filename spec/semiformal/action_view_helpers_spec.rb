require 'spec_helper'
require 'semiformal/action_view_helpers'

describe Semiformal::ActionViewHelpers do
  let(:target) { Model.new }
  let(:controller) { Controller.new }
  let(:form) { Semiformal::Form.new(controller, target) }

  it "generates a form for the given object" do
    rendered = Renderer.render %{
      <%= render_form form do |form| -%>
        <span>inner</span>
      <% end -%>
    }, :form => form

    rendered.should have_css("form#new_model.model[action='/models'][method='post']")
    rendered.should have_css("span:contains('inner')")
  end
end

