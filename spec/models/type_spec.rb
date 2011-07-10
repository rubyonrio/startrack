require 'spec_helper'

describe Type do
  let(:type) { Factory.build(:type) }
  describe "Validates" do
    it "should not save without a name" do
      type.name = nil
      type.valid?.should be_false
    end
  end
end
