require 'spec_helper'

describe TasksController do
  let(:project) { projects(:first_journey) }
  let(:task) { tasks(:create_enterprise) }

  before(:each) do
    login!
  end

  it "shoud get show" do
    get :show, project_id: project.id, id: task.id
    assigns(:task).should == task
    assigns(:comments).should == task.comments
    response.code.should eq("200")
  end

  it "should get edit" do
    get :edit, project_id: project.id, id: task.id
    assigns(:task).should == task
    response.code.should eq("200")
  end

  it "should change task status" do
    get :change_status, project_id: project.id, id: task.id, status_id: 2
    assigns(:task).status.name.should == 'Scheduled'
  end

  describe "POST create" do
    def do_action(attributes = {})
      post(:create, project_id: task.project, task: attributes)
    end

    context "valid attributes" do
      before(:each) do
        do_action( name: "Hidden Project", status_id: 1, type_id: 1 )
      end

      it { should assign_to(:task)}
      it { assigns(:task).user.should == subject.current_user }
      it { should redirect_to(task.project) }
      it { should set_the_flash.to("Task was successfully created.") }
    end

    context "invalid attributes" do
      before(:each) do
        do_action
      end

      it { should redirect_to(task.project) }
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
          @status = statuses(:scheduled)
          @type = types(:feature)
          do_action({name: "New Project name", status_id: @status.id, type_id: @type.id, watcher_ids: [users(:spok).id]})
        end

        it { should assign_to(:task)}
        it { assigns(:watchers_changes).should == {"removed" => [users(:kirk).id], "added" => [users(:spok).id]} }
        it { assigns(:task_changes).should == { "name" => [task.name, "New Project name"], "status_id" => [task.status.name, @status.name],
          "responsible_id" => ["None yet", "None yet"], "type_id" => [task.type.name, @type.name], "estimate_id" => ["None yet", "None yet"] } }
        it { should redirect_to(project_task_path(project,task)) }
        it { should set_the_flash.to("Task was successfully updated.") }
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

  it "shoud get start" do
    get :start, project_id: project.id, id: task.id
    response.code.should eq("406")
  end

  it "shoud get stop" do
    get :start, project_id: project.id, id: task.id
    get :stop, project_id: project.id, id: task.id
    response.code.should eq("406")
  end

end

