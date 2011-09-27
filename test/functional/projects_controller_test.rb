require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProjectsControllerTest < ActionController::TestCase

  setup do
    @project = projects(:first_journey)
    @current_user = users(:spok)
    @another_user = users(:kirk)
    sign_in @current_user
  end

  test "should list all projects of the user" do
    get :index
    assert_equal assigns(:projects), @current_user.projects
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test "should create a new project with relationship with user" do
    assert_difference('Project.count') do
      post :create, project: {name: "Skatepark", user_ids: [@current_user.id]}
    end

    assert_redirected_to project_path(assigns(:project))
    assert_equal "Project was successfully created.", flash[:notice]
  end


  test "should not create a new project if don't have the requirements" do
    post :create, project: {name: "", user_ids: [@current_user.id]}
      assert_nil flash[:notice]
  end

  test "should show all related kind of task for a project" do
    get :show, id: @project.to_param
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:task_todo)
    assert_not_nil assigns(:task_scheduled)
    assert_not_nil assigns(:task_current)
    assert_not_nil assigns(:task_done)
  end

  test "should get edit" do
    get :edit, id: @project.id
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test "should update a project" do
    put :update, id: @project.id
    assert_equal 'Project was successfully updated.', flash[:notice]
    assert_redirected_to project_path(assigns(:project))
  end

  test "should not update a project if don't have the requirements" do
    put :update, id: @project.id, project: {name: ''}
    assert_nil flash[:notice]
  end

  test "should delete a project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project.id
    end
  end

  test "should redirect to root_path if user does'nt have permission" do
    @project.users.include?(@another_user)
    get :show, id: @project.to_param
    assert_redirected_to :root_path
  end
end
