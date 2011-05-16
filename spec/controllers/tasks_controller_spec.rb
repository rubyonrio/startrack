require 'spec_helper'

describe TasksController do

  before(:each) do
    login_user
  end

  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all tasks as @tasks" do
      task = Task.create! valid_attributes
      get :index
      assigns(:tasks).should eq([task])
    end
  end

  describe "GET show" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      get :show, :id => task.id.to_s
      assigns(:task).should eq(task)
    end
  end

  describe "GET new" do
    it "assigns a new task as @task" do
      get :new
      assigns(:task).should be_a_new(Task)
    end
  end

  describe "GET edit" do
    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      get :edit, :id => task.id.to_s
      assigns(:task).should eq(task)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, :task => valid_attributes
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, :task => valid_attributes
        assigns(:task).should be_a(Task)
        assigns(:task).should be_persisted
      end

      it "redirects to the created task" do
        post :create, :task => valid_attributes
        response.should redirect_to(Task.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, :task => {}
        assigns(:task).should be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        post :create, :task => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested task" do
        task = Task.create! valid_attributes
        # Assuming there are no other tasks in the database, this
        # specifies that the Task created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Task.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => task.id, :task => {'these' => 'params'}
      end

      it "assigns the requested task as @task" do
        task = Task.create! valid_attributes
        put :update, :id => task.id, :task => valid_attributes
        assigns(:task).should eq(task)
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, :id => task.id, :task => valid_attributes
        response.should redirect_to(task)
      end
    end

    describe "with invalid params" do
      it "assigns the task as @task" do
        task = Task.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, :id => task.id.to_s, :task => {}
        assigns(:task).should eq(task)
      end

      it "re-renders the 'edit' template" do
        task = Task.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Task.any_instance.stub(:save).and_return(false)
        put :update, :id => task.id.to_s, :task => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, :id => task.id.to_s
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, :id => task.id.to_s
      response.should redirect_to(tasks_url)
    end
  end

end
