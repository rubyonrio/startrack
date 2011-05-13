require 'spec_helper'

describe "stories/new.html.erb" do
  before(:each) do
    assign(:story, stub_model(Story,
      :name => "MyString",
      :description => "MyText",
      :task => nil,
      :project => nil
    ).as_new_record)
  end

  it "renders new story form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stories_path, :method => "post" do
      assert_select "input#story_name", :name => "story[name]"
      assert_select "textarea#story_description", :name => "story[description]"
      assert_select "input#story_task", :name => "story[task]"
      assert_select "input#story_project", :name => "story[project]"
    end
  end
end
