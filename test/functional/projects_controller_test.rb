require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProjectsControllerTest < ActionController::TestCase

  setup do
    @project = projects(:first_journey)
    @current_user = users(:spok)
    sign_in @current_user
  end

  test "should list all projects of the user" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a project" do
    project = @current_user.projects.build(name: "New project", description: "Description")
    assert_difference('Project.count') do
      post :create, project: project.attributes
    end

    assert_equal 1, project.users.length
    assert_not_nil project
    assert_redirected_to project_path(assigns(:project))
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

