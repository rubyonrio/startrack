require 'spec_helper'

describe "routing" do
  it "recognizes and generates #index" do
    get("/projects/1/tasks").should_not be_routable
  end

  it "recognizes and generates #new" do
     get("/projects/1/tasks/new").should route_to(:controller => "tasks", :action => "new", :project_id => "1")
     new_project_task_path("1").should == "/projects/1/tasks/new"
   end
 
   it "recognizes and generates #create" do
     post("/projects/1/tasks").should route_to(:controller => "tasks", :action => "create", :project_id => "1")
     project_tasks_path("1").should == "/projects/1/tasks"
   end

   it "recognizes and generates #edit" do
     get("/projects/1/tasks/1/edit").should route_to(:controller => "tasks", :action => "edit", :project_id => "1", :id => "1")
     edit_project_task_path("1","1").should == "/projects/1/tasks/1/edit"
   end
 
   it "recognizes and generates #update" do
     put("/projects/1/tasks/1").should route_to(:controller => "tasks", :action => "update", :project_id => "1", :id => "1")
     project_task_path("1", "1").should == "/projects/1/tasks/1"
   end

  it "recognizes and generates #destroy" do
    delete("/projects/1/tasks/1").should route_to(:controller => "tasks", :action => "destroy", :project_id => "1", :id => "1")
    project_task_path("1", "1").should == "/projects/1/tasks/1"
  end

  it "recognizes and generates #show" do
    get("/projects/1/tasks/1").should route_to(:controller => "tasks", :action => "show", :project_id => "1", :id => "1")
    project_task_path("1", "1").should == "/projects/1/tasks/1"
  end 
end