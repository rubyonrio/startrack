require 'spec_helper'

describe CommentsController do
  describe "GET destroy" do
    it_should_behave_like "authentication_required_action"
    let(:comment) { comments(:one) }

    def do_action
      delete(:destroy, :id => comment.id)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      it "should delete a comment" do
        expect {
          do_action
        }.to change(Comment, :count).by(-1)
      end

      it "should redirect to task show" do
        do_action
        should redirect_to('http://test.host/tasks/587127017')
      end
    end
  end
end
