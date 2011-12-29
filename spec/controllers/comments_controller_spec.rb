require 'spec_helper'

describe CommentsController do
  let(:project) { projects(:first_journey)}
  let(:task) { tasks(:create_enterprise) }
  let(:comment) { comments(:one) }

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

        it { should assign_to(:task)}
        it { should redirect_to(project_task_path(project,task)) }
        it { should set_the_flash.to("Comment was successfully created.") }
      end

      context "invalid attributes" do
        before(:each) do
          do_action
        end
        
        it { should set_the_flash.to("Comment was not created.") }
      end
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
