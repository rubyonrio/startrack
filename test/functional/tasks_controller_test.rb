require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class TasksControllerTest < ActionController::TestCase

  def setup
    @project = projects(:first_journey)
    @task = tasks(:create_enterprise)
    sign_in users(:spok)
  end

  test "should show a task" do
    get :show, id: @task.id
    assert_response :success
    assert_not_nil assigns(:task)
  end

  test "should get new" do
    get :new, project_id: @project.id
    assert_response :success
    assert_not_nil assigns(:task)
  end

  test "should create task" do
    @task.task_files << task_files(:one)
    assert_equal "MyString", @task.task_files.first.file_name
    assert_difference('Task.count') do
      post :create, project_id: @project.id, task: @task.attributes
    end

    assert_redirected_to project_path(assigns(:project))
    assert_equal "Task was successfully created.", flash[:notice]
  end

  test "should update task" do
    post :update, id: @task.id, task: {name: 'Testing'}

    assert_redirected_to task_path(assigns(:task))
    assert_equal "Task was successfully updated.", flash[:notice]
  end

  test "should get edit" do
    get :edit, id: @task.id
    assert_response :success
    assert_not_nil assigns(:task)
  end

  test "should change a task status to current" do
    put :change_status, id: @task, status_id: 3
    assert_equal 3, assigns(:task).status_id
  end
end
