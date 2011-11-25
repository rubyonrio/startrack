require 'test_helper'

class TasksHelperTest < ActionView::TestCase

  def setup
    @task = tasks(:create_enterprise)
  end

  test "should render a link_to_show_task" do
    assert_equal link_to_show_task(@task), link_to("##{@task.id} Bug - Create Enterprise", task_path(@task), class: "todo bug")
  end

  test "should return nil if do not have task description" do
    assert_equal show_task_description(@task), nil
  end

  test "should render description with html safe" do
    @task.update_attribute :description, "The Immunity Syndrome"
    assert_equal show_task_description(@task), "<p>The Immunity Syndrome</p>"
  end
end
