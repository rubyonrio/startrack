require 'spec_helper'

describe ProjectsController do

  before(:each) do
    login_user
  end

  describe "GET index" do
    before(:each) do
      @projects = [mock_model(Project), mock_model(Project)]
      Project.stub!(:all).and_return(@projects)
      get :index
    end

    it "get index and return projects list" do
      response.should be_success
    end

    it "renders index template" do
      response.should render_template("index")
    end

    it "list all projects" do
      assigns[:projects].should == @projects
    end

  end
end
