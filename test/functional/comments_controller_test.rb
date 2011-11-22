require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CommentsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:first_journey)
    @current_user = users(:spok)
    sign_in @current_user
  end
  
  context "detroy" do
    context "valid id" do
      should "should delete a comment" do
        comment = comments(:one)
        get :destroy, :id => comment.id
        assert_redirected_to task_url(assigns(:comment).task)
      end
    end
    context "invalid id" do
      should "should raise ActiveRecord::RecordNotFound" do
        assert_raise(ActiveRecord::RecordNotFound) do
          get :destroy, :id => 7634
        end
      end
    end
  end
end