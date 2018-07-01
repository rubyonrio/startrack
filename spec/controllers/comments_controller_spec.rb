require 'rails_helper'

describe CommentsController do
  let(:project) { create(:project, name: 'First Journey') }
  let(:user) { create(:user, name: 'Spok') }
  let(:task) { create(:task, name:'Create Enterprise', user: user, project: project) }
  let(:comment) { create(:comment, user: user, task: task) }

  describe "POST create" do
    before do
      sign_in(user)
    end

    def do_action(attributes = {})
      post(:create, project_id: project.id, task_id: task.id, comment: attributes)
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
      end

      context "valid attributes" do
        before(:each) do
          do_action(description: "Hidden Project")
        end

        it { expect(assigns(:task)) }
        it { expect(redirect_to(project_task_path(project, task))) }
        it { expect(set_flash.to("Comment was successfully created.")) }

      end

      context "invalid attributes" do
        before(:each) do
          do_action
        end

        xit { expect(set_flash.to("Comment was not created.")) }

      end
    end
  end

  describe "GET destroy" do

    context "authenticated" do
      before(:each) do
        sign_in(user)
        @comment_to_delete = create(:comment, task: task, user: user)
      end

      it "should delete a comment" do
        expect {
          delete(:destroy, project_id: project.id, task_id: task.id, id: @comment_to_delete.id)
        }.to change(Comment, :count).by(-1)
      end

      it "should redirect to task show" do
        delete(:destroy, project_id: project.id, task_id: task.id, id: @comment_to_delete.id)
        should redirect_to(project_task_path(project, task))
      end
    end
  end
end
