require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:kirk)
  end

  test "should not save without name" do
    @user.name = nil
    assert !@user.save
  end

  test "has many comments" do
    @comment_one = comments(:one)
    @comment_two = comments(:two)

    @user.comments << @comment_one
    @user.comments << @comment_two
    assert_equal(@user.comments.length, 2)
  end

end
