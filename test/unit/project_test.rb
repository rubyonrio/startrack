require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = projects(:one)
  end

  test "should not save without a name" do
    @project.name = nil
    assert !@project.save
  end

  test "should have many users" do
    @user_one = users(:one)
    @user_two = users(:two)

    @project.users << @user_one
    @project.users << @user_two

    assert_equal(@project.users.length, 2)
  end

  test "should have many tasks" do
    @task_one = tasks(:one)
    @task_two = tasks(:two)

    @project.tasks << @task_one
    @project.tasks << @task_two

    assert_equal(@project.tasks.length, 2)
  end


end