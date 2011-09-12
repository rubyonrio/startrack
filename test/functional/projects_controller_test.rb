require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProjectsControllerTest < ActionController::TestCase

  setup do
    @project = projects(:first_journey)
    sign_in users(:spok)
  end

  test "should respond success" do
    get :show, id: @project.to_param
    assert_response :success
  end

  test "should show all related kind of task for a project" do
    get :show, id: @project.to_param
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:task_todo)
    assert_not_nil assigns(:task_scheduled)
    assert_not_nil assigns(:task_current)
    assert_not_nil assigns(:task_done)
  end
end
