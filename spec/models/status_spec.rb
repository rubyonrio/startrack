require 'spec_helper'

describe Status do
  let(:status) { Factory.build(:status) }
  describe "Validates" do
    it "should not save without a name" do
      status.name = nil
      status.valid?.should be_false
    end
  end
end
