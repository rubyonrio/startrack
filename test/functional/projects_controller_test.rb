require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class ProjectsControllerTest < ActionController::TestCase

  setup do
    @project = projects(:first_journey)
    @current_user = users(:spok)
    sign_in @current_user
    @mccoy = users(:mccoy)
    @kirk = users(:kirk)
  end

  test "should list all projects of the user" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not associate the current_user to the users list" do
    get :new
    assert_equal [@kirk,@mccoy], assigns(:users)
  end
  
  test "should associate current_user to created a project by default" do
    post :create, :project => {"name"=>"outro duplicado", "user_ids"=>[@mccoy.id]}
    assert_equal assigns(:project).users, [@mccoy, @current_user]
  end

  test "should show all related kind of task for a project" do
    get :show, id: @project.id
    puts "\n\n-> #{@project.tasks}\n\n"
    assert_not_nil assigns(:tasks)
    assert_not_nil assigns(:task_todo)
    assert_not_nil assigns(:task_scheduled)
    assert_not_nil assigns(:task_current)
    assert_not_nil assigns(:task_done)
  end
end
