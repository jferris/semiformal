require 'spec_helper'
require 'semiformal/form'

describe Semiformal::Form do
  let(:target) { Object.new }
  subject { Semiformal::Form.new(target) }

  it "has a target" do
    subject.target.should == target
  end
end

