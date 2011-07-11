require 'spec_helper'

describe Estimate do
  let(:estimate) { Factory.build(:estimate) }
  describe "Validates" do
    it "should not save without a name" do
      estimate.name = nil
      estimate.valid?.should be_false
    end
  end
end
