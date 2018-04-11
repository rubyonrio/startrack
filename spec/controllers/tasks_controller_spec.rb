require 'rails_helper'

describe TasksController do
  let(:project) { Project.find_by_name('First Journey') }
  let(:task) { Task.find_by_name('Create Enterprise') }
  before(:each) do
    login!
  end

  context "shoud get show" do

    before do
      get(:show, project_id: project.id, id: task.id)
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(assigns(:comments)).to eq(task.comments)}
    it {expect(response.code).to eq("200")}
  end

  context "should get edit" do
    before do
      get :edit, project_id: project.id, id: task.id
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(response.code).to eq("200")}
  end

   context "should change task status" do
     before do
      get(:change_status, project_id: project.id, id: task.id, status: 'Scheduled')
     end

     it {expect(assigns(:task).status.name).to eq('Scheduled')}
  end

  describe "POST create" do
    def do_action(attributes = {})
      post(:create, project_id: task.project, task: attributes)
    end

    context "valid attributes" do
      before(:each) do
        do_action( name: "Hidden Project", status_id: 1, type_id: 1 )
      end

      it { expect(assigns(:task))}
      it { expect(assigns(:task).user).to eq(subject.current_user) }
      it { expect(response).to redirect_to(project_task_path(assigns(:task).project, assigns(:task))) }
      it { should set_flash.to("Task was successfully created.") }
    end

    context "invalid attributes" do
      before(:each) do
        do_action
      end

      it { expect(response).to redirect_to(project_path(task.project_id)) }
    end
  end

  describe "PUT update" do
    def do_action(attributes = {})
      put(:update, project_id: project.id, id: task.id, task: attributes)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      context "valid attributes" do
        before(:each) do
          @status = Status.find_by_name(Task::STATUSES[:scheduled])
          @type = ::Type.find_by_name(Task::TYPES[:feature])
          @spok = User.find_by_name("Spok")
          @kirk = User.find_by_name("Commander Kirk")
          do_action({name: "New Project name", status_id: @status.id, type_id: @type.id, watcher_ids: [@spok.id]})
        end

        it { expect(assigns(:task)) }
        it { expect(assigns(:watchers_changes)).to eq({added: [@spok.id], removed: [@kirk.id]})}
        it { assigns(:task_changes).should == { "name" => [task.name, "New Project name"], "status_id" => [task.status.name, @status.name],
          "responsible_id" => ["None yet", "None yet"], "type_id" => [task.type.name, @type.name], "estimate_id" => ["None yet", "None yet"] } }
        it { should redirect_to(project_task_path(project,task)) }
        it { should set_flash.to("Task was successfully updated.") }
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
      delete(:destroy, project_id: project.id, :id => task.id)
    end

    context "authenticated" do
      before(:each) do
        login!
      end

      it "should delete a task" do
        expect {
          do_action
        }.to change(Task, :count).by(-1)
      end

      it "should redirect to project url" do
        do_action
        should redirect_to(task.project)
      end
    end
  end

  context "shoud get start" do
    before do
      get :start, project_id: project.id, id: task.id
    end
    it {expect(response.code).to eq("302")}
  end

  context "shoud get stop" do
    before do
      get :start, project_id: project.id, id: task.id
      get :stop, project_id: project.id, id: task.id
    end
    it {expect(response.code).to eq("302")}
  end

end

