require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = projects(:first_journey)
  end

  test "should not save without a name" do
    @project.name = nil
    assert !@project.save
  end

  test "should have many users" do
    @user_one = users(:kirk)
    @user_two = users(:spok)

    @project.users << @user_one
    @project.users << @user_two

    assert_equal(@project.users.length, 2)
  end

  test "should have many tasks" do
    @task_one = tasks(:create_enterprise)
    @task_two = tasks(:room_galaxy)

    @project.tasks << @task_one
    @project.tasks << @task_two

    assert_equal(@project.tasks.length, 2)
  end


end
