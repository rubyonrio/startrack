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

end
