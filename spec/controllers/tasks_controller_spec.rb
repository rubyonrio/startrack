require 'rails_helper'

describe TasksController do
  let(:project) {create(:project)}
  let(:user) {create(:user)}
  let(:task) {create(:task, user: user, project: project)}
  let(:type) {create(:type, name:'Bug')}
  let(:status) {create(:status, name: 'Scheduled')}

  before(:each) do
    project.users << user
    sign_in(user)
  end

  context "get show" do

    before do
      get(:show, project_id: project.id, id: task.id)
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(assigns(:comments)).to eq(task.comments)}
    it {expect(response.code).to eq("200")}
  end

  context "get edit" do
    before do
      get :edit, project_id: project.id, id: task.id
    end

    it {expect(assigns(:task)).to eq(task)}
    it {expect(response.code).to eq("200")}
  end

   context "change task status" do
     before do
      get(:change_status, project_id: project.id, id: task.id, status: status.name)
     end

     it "assign tasks correctly" do 
      expect(assigns(:task).status.name).to eq('Scheduled')
     end
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
    def do_action(project_id, task_id, attributes = {})
      put(:update, project_id: project_id, id: task_id, task: attributes)
    end

    context "authenticated" do

      context "valid attributes" do
        before(:each) do
          @type = create(:type, name: 'Feature')
          @spok = create(:user, name: 'Spok')
          @kirk = create(:user, name: 'Commander Kirk')
          @status = create(:status, name: 'Done')
          @task = create(:task, user: @kirk, project: project, watchers: [@kirk], type: type, status: status)
          @name = 'New task name'

          do_action(project.id, @task.id, {name: @name, status_id: @status.id, type_id: @type.id, watcher_ids: [@spok.id]})
        end

        it { expect(assigns(:task)) }
        it { expect(assigns(:watchers_changes)).to eq({added: [@spok.id], removed: [@kirk.id]})}
        it { expect(assigns(:task_changes)).to include({ "name" => [@task.name, @name], "status_id" => [@task.status.name, @status.name],
          "responsible_id" => ["None yet", "None yet"], "type_id" => [@task.type.name, @type.name], "estimate_id" => ["None yet", "None yet"] }) }
        it { should redirect_to(project_task_path(project,@task)) }
        it { should set_flash.to("Task was successfully updated.") }
      end

      context "invalid attributes" do
        before(:each) do
          do_action(project.id, task.id, name: "")
        end

        it { should render_template(:edit) }
      end
    end
  end

  describe "GET destroy" do

    context "authenticated" do
      before(:each) do
        sign_in(user)
        @task_to_destroy = create(:task, project: project)
      end

      it "should delete a task" do
        expect {
          delete(:destroy, project_id: project.id, :id => @task_to_destroy.id)
        }.to change(Task, :count).by(-1)
      end

      it "should redirect to project url" do
        delete(:destroy, project_id: project.id, :id => @task_to_destroy.id)
        should redirect_to(project)
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

