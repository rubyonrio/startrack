require 'spec_helper'

describe ProjectsController do
  describe "GET index" do
    it_should_behave_like "authentication_required_action"
    let(:project) { projects(:first_journey) }

    def do_action
      get(:index)
    end

    context "authenticated" do
      before(:each) do
        login!
        do_action
      end

      it { assigns(:projects).should == [project] }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end

  describe "GET new" do
    it_should_behave_like "authentication_required_action"

    def do_action
      get(:new)
    end

    context "authenticated" do
      before(:each) do
        login!
        do_action
      end

      it { should assign_to(:project) }
      it { should assign_to(:users) }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end
  
  describe "GET edit" do
    it_should_behave_like "authentication_required_action"
    let(:project) { projects(:first_journey) }

    def do_action
      get(:edit, :id => project.id)
    end

    context "authenticated" do
      before(:each) do
        login!
        do_action
      end

      it { assigns(:project).should == project }
      it { should assign_to(:users) }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
  end

  describe "GET destroy" do
    it_should_behave_like "authentication_required_action"
    let(:project) { projects(:first_journey) }

    def do_action
      delete(:destroy, :id => project.id)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      it "should delete a comment" do
        expect {
          do_action
        }.to change(Project, :count).by(-1)
      end

      it "should redirect to projects url" do
        do_action
        should redirect_to(projects_url)
      end
    end
  end
end
