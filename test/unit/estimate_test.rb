require 'test_helper'

class EstimateTest < ActiveSupport::TestCase
  def setup
    @estimate = estimates(:fast)
  end

  test "should not save without a name" do
    @estimate.name = nil
    assert !@estimate.save
  end

end
