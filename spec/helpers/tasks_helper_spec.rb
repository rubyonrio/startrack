require 'spec_helper'

describe TasksHelper do
  let(:project) { projects(:first_journey) }
  let(:task) { tasks(:create_enterprise) }

  describe "link_to_show_task" do
    it "does something" do
      helper.link_to_show_task(project, task).should == "<a href=\"#{project_task_path(project,task)}\" class=\"todo bug\">##{task.id} #{task.type.name} - #{task.name}</a>"
    end
  end

  describe "show_task_description" do
    context "when task is nil" do
      it "does something" do
        task.description_html = nil
        helper.show_task_description(task).should == "Something cool here!"
      end
    end

    context "when task is not nil" do
      it "does something" do
        helper.show_task_description(task).should == "<p>Something cool here!</p>"
      end
    end
  end
end
