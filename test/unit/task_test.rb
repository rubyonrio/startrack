require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:create_enterprise)
  end

  test "should not save without name" do
    @task.name = nil
    assert !@task.save
  end

  test "shoud not save without type" do
    @task.type = nil
    assert !@task.save
  end

  test "shoud not save without a status" do
    @task.status = nil
    assert !@task.save
  end

  test "should not save without an user" do
    @task.user = nil
    assert !@task.save
  end

  test "should require a project" do
    @task.project = nil
    assert !@task.save
  end

  test "should require a type" do
    @task.type = nil
    assert !@task.save
  end

  test "should require a status" do
    @task.status = nil
    assert !@task.save
  end

  test "should return 'No responsible yet' if do not have a responsible" do
    @task.responsible = nil
    assert @task.show_responsible_name, 'No responsible yet'
  end

  test "should return 'No estimative yet'if do not have a estimative" do
    @task.estimate = nil
    assert @task.show_estimate_name, 'No estimative yet'
  end

  test "should have many comments" do
    @comment_one = comments(:one)
    @comment_two = comments(:two)

    @task.comments << @comment_one
    @task.comments << @comment_two
    assert_equal(@task.comments.length, 2)
  end
end
