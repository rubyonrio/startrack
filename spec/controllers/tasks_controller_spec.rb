require 'spec_helper'

describe TasksController do

  let(:task) { tasks(:create_enterprise) }

  before(:each) do
    login!
  end

  it "shoud get show" do
    get :show, id: task.id
    assigns(:task).should == task
    assigns(:comments).should == task.comments
    response.code.should eq("200")
  end

  it "should get new" do
    project = task.project
    get :new, project_id: project.id
    assigns(:project).should == project
    response.code.should eq("200")
  end

  it "should get edit" do
    get :edit, id: task.id
    assigns(:task).should == task
    response.code.should eq("200")
  end

end
