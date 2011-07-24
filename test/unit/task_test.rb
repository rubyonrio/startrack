require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
    @task = tasks(:one)
  end

  test "should not save without name" do
    @task.name = nil
    assert !@task.save
  end

  test "shoud return 'no-type' in 'show_type_name' method if task do not have type" do
    @task.type = nil
    assert_equal(@task.show_type_name, 'no-type')
  end

  test "shoud return 'no-type' in 'show_type_parameterize_name' method if task do not have type" do
    @task.type = nil
    assert_equal(@task.show_type_parameterize_name, 'no-type')
  end

  test "shoud return 'no-status' in 'show_status_name' method if task do not have status" do
    @task.status = nil
    assert_equal(@task.show_status_name, 'no-status')
  end

  test "shoud return 'no-status' in 'show_status_parameterize_name' method if task do not have status" do
    @task.status = nil
    assert_equal(@task.show_status_parameterize_name, 'no-status')
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

  test "should have many comments" do
    @comment_one = comments(:one)
    @comment_two = comments(:two)

    @task.comments << @comment_one
    @task.comments << @comment_two
    assert_equal(@task.comments.length, 2)
  end
end
