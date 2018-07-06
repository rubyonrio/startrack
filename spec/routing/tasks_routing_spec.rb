require 'rails_helper'

describe "routing" do
  it "recognizes and generates #index" do
    expect(get("/projects/1/tasks")).not_to be_routable
  end

   it "recognizes and generates #create" do
     expect(post("/projects/1/tasks")).to route_to(:controller => "tasks", :action => "create", :project_id => "1")
     expect(project_tasks_path("1")).to eq("/projects/1/tasks")
   end

   it "recognizes and generates #edit" do
     expect(get("/projects/1/tasks/1/edit")).to route_to(:controller => "tasks", :action => "edit", :project_id => "1", :id => "1")
     expect(edit_project_task_path("1","1")).to eq("/projects/1/tasks/1/edit")
   end

   it "recognizes and generates #update" do
     expect(put("/projects/1/tasks/1")).to route_to(:controller => "tasks", :action => "update", :project_id => "1", :id => "1")
     expect(project_task_path("1", "1")).to eq("/projects/1/tasks/1")
   end

  it "recognizes and generates #destroy" do
    expect(delete("/projects/1/tasks/1")).to route_to(:controller => "tasks", :action => "destroy", :project_id => "1", :id => "1")
    expect(project_task_path("1", "1")).to eq("/projects/1/tasks/1")
  end

  it "recognizes and generates #show" do
    expect(get("/projects/1/tasks/1")).to route_to(:controller => "tasks", :action => "show", :project_id => "1", :id => "1")
    expect(project_task_path("1", "1")).to eq("/projects/1/tasks/1")
  end
end
