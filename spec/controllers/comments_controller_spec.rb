require 'spec_helper'

describe CommentsController do
  describe "GET destroy" do
    #TODO: implement authentication required
    let(:comment) { comments(:one) }

    def do_action
      get(:destroy, :id => comment.id)
    end

    context "authenticated" do
      before(:each) do
        #TODO: create authentication
        do_action
      end

      it { should redirect_to('http://test.host/tasks/587127017') }
    end
  end
end
