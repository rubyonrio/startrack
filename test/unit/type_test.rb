require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  def setup
    @type = types(:feature)
  end

  test "should not create without name" do
    @type.name = nil
    assert !@type.save
  end
end
