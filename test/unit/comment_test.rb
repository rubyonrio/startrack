require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:one)
  end

  test "should not save without a description" do
    @comment.description = nil
    assert !@comment.save
  end

  test "should not save without an user" do
    @comment.user = nil
    assert !@comment.save
  end

  test "should not save without a task" do
    @comment.task = nil
    assert !@comment.save
  end

end
