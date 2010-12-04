require 'spec_helper'
require 'action_view'
require 'semiformal/action_view_helpers'

describe Semiformal::ActionViewHelpers do
  let(:target) { Model.new }
  let(:form) { Semiformal::Form.new(target) }

  it "generates a form for the given object" do
    rendered = Renderer.render %{
      <%= render_form form do |form| -%>
        <span>inner</span>
      <% end -%>
    }, :form => form

    rendered.should have_css("form#new_model.new_model[action='/models'][method='post']")
    rendered.should have_css("span:contains('inner')")
  end
end

