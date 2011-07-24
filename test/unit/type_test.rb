require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  def setup
    @type = types(:one)
  end

  test "should not create without name" do
    @type.name = nil
    assert !@type.save
  end
end
