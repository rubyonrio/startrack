require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  def setup
    @status = statuses(:todo)
  end

  test "should not save without a name" do
    @status.name = nil
    assert !@status.save
  end

  test "should have many tasks" do
    @task_one = tasks(:create_enterprise)
    @task_two = tasks(:room_galaxy)

    @status.tasks << @task_one
    @status.tasks << @task_two
    assert_equal(@status.tasks.length, 2)
  end

end
