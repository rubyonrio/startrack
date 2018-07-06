require 'rails_helper'

describe ProjectsController do
  let(:user) {create(:user)}
  let(:project) { create(:project, name: 'First Journey', users: [user]) }
  describe "GET index" do

    def do_action
      get(:index)
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
        do_action
      end

      it { expect(assigns(:projects)).to eq([project]) }
      it { should respond_with(:success) }
      it { should render_template(:index) }
    end
  end

  describe "GET show" do

    def do_action
      get :show, params: { id: project.id }
    end

    context "authenticated" do
      context "belong to the current user" do
        before(:each) do
          sign_in(user)
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
        let(:project) { create(:project, name: 'New project') }

        before(:each) do
          sign_in(user)
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

    def do_action
      get(:new)
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
        do_action
      end

      it { expect(assigns(:project)) }
      it { expect(assigns(:users)) }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

  describe "POST create" do

    def do_action(attributes = {})
      post :create, params: { project: attributes }
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
      end

      context "valid attributes" do
        before(:each) do
          do_action( name: "Hidden Project")
        end

        it { expect(assigns(:project)) }
        it { expect(assigns(:project).users).to eq([subject.current_user]) }
        it { should redirect_to(assigns(:project)) }
        it { should set_flash.to("Project was successfully created.") }
      end

      context "invalid attributes" do
        before(:each) do
          do_action( name: '' )
        end

        it { should render_template(:new) }
        it { should respond_with(:success) }
      end
    end
  end

  describe "PUT update" do

    def do_action(attributes = {})
      put :update, params: { id: project.id, project: attributes }
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
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

    def do_action
      delete :destroy, params: { id: project.id }
    end

    context "authenticated" do
      before(:each) do
        sign_in(user)
      end

      it "should delete a project" do
        project_to_delete = create(:project, users: [user])
        expect {
          delete :destroy, params: { id: project_to_delete.id }
        }.to change(Project, :count).by(-1)
      end

      it "should redirect to projects url" do
        do_action
        should redirect_to(projects_path)
      end
    end
  end
end
