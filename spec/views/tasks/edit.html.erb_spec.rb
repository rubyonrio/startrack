require 'spec_helper'

describe "tasks/edit.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "MyString",
      :description => "MyText",
      :estimate => 1,
      :status => 1,
      :type => 1,
      :user => nil,
      :story => nil
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tasks_path(@task), :method => "post" do
      assert_select "input#task_name", :name => "task[name]"
      assert_select "textarea#task_description", :name => "task[description]"
      assert_select "input#task_estimate", :name => "task[estimate]"
      assert_select "input#task_status", :name => "task[status]"
      assert_select "input#task_type", :name => "task[type]"
      assert_select "input#task_user", :name => "task[user]"
      assert_select "input#task_story", :name => "task[story]"
    end
  end
end
