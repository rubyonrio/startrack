require 'rails_helper'

describe CommentsController do
  let(:project) { Project.find_by_name('First Journey') }
  let(:task) { Task.find_by_name('Create Enterprise') }
  let(:user) { User.find_by_name('Spok') }
  let(:comment) { Comment.find_by(user: user) }

  describe "POST create" do
    it_should_behave_like "authentication_required_action"

    def do_action(attributes = {})
      post(:create, project_id: project.id, task_id: task.id, comment: attributes)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      context "valid attributes" do
        before(:each) do
          do_action( description: "Hidden Project")
        end

        it { expect(assigns(:task)) }
        it { expect(redirect_to(project_task_path(project, task))) }
        it { expect(set_flash.to("Comment was successfully created.")) }

      end

     # context "invalid attributes" do
     #   before(:each) do
     #     do_action
     #   end

     #   it { expect(set_flash.to("Comment was not created.")) }

     # end
    end
  end

  describe "GET destroy" do
    it_should_behave_like "authentication_required_action"

    def do_action
      delete(:destroy, project_id: project.id, task_id: task.id, id: comment.id)
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
        should redirect_to(project_task_path(project, task))
      end
    end
  end
end
