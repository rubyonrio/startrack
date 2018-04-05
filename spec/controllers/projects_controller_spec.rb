require 'rails_helper'

describe ProjectsController do
  describe "GET index" do
    it_should_behave_like "authentication_required_action"
    let(:project) { Project.find_by_name('First Journey') }

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

  describe "GET show" do
    it_should_behave_like "authentication_required_action"
    let(:project) { Project.find_by_name('First Journey') }

    def do_action
      get(:show, :id => project.id)
    end

    context "authenticated" do
      context "belong to the current user" do
        before(:each) do
          login!
          do_action
        end

        it { expect(assigns(:project)) }
        it { expect(assigns(:tasks)) }
        it { expect(assigns(:task_todo)) }
        it { expect(assigns(:task_scheduled)) }
        it { expect(assigns(:task_current)) }
        it { expect(assigns(:task_done)) }
        it { should respond_with(:success) }
        it { should render_template(:show) }
      end

      context "but not belong to the current user" do
        let(:project) { Project.find_by_name('Mike Vallely') }

        before(:each) do
          login!
        end

        it "should raise an ActiveRecord::RecordNotFound" do
          expect {
            do_action
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
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

      it { expect(assigns(:project)) }
      it { expect(assigns(:users)) }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

  describe "POST create" do
    it_should_behave_like "authentication_required_action"

    def do_action(attributes = {})
      post(:create, project: attributes)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      context "valid attributes" do
        before(:each) do
          do_action( name: "Hidden Project")
        end

        it { expect(assigns(:project)) }
        it { assigns(:project).users.should == [subject.current_user] }
        it { should redirect_to(assigns(:project)) }
        it { should set_flash.to("Project was successfully created.") }
      end

     # context "invalid attributes" do
     #   before(:each) do
     #     do_action
     #   end

     #   it { should render_template(:new) }
     #   it { should respond_with(:success) }
     # end
    end
  end

  describe "GET edit" do
    it_should_behave_like "authentication_required_action"
    let(:project) { Project.find_by_name('First Journey') }

    def do_action
      get(:edit, :id => project.id)
    end

    context "authenticated" do
      before(:each) do
        login!
        do_action
      end
      kirk = User.find_by_name('Commander Kirk')
      mccoy = User.find_by_name('Leonard McCoy')
      it { assigns(:project).should == project }
      it { assigns(:users).should == [kirk, mccoy] }
      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
  end

  describe "PUT update" do
    it_should_behave_like "authentication_required_action"
    let(:project) { Project.find_by_name('First Journey') }

    def do_action(attributes = {})
      put(:update, id: project.id, project: attributes )
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      context "valid attributes" do
        before(:each) do
          do_action( name: "New Project name")
        end

        it { expect(assigns(:project)) }
        it { should redirect_to(assigns(:project)) }
        it { should set_flash.to("Project was successfully updated.") }
      end

      context "invalid attributes" do
        before(:each) do
          do_action(name: "")
        end

        it { should render_template(:edit) }
      end
    end
  end

  describe "GET destroy" do
    it_should_behave_like "authentication_required_action"
    let(:project) { Project.find_by_name('First Journey') }

    def do_action
      delete(:destroy, :id => project.id)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      it "should delete a project" do
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
