require 'spec_helper'

describe TasksHelper do
  let(:task) { tasks(:create_enterprise) }

  describe "link_to_show_task" do
    it "does something" do
      helper.link_to_show_task(task).should == "<a href=\"/tasks/587127017\" class=\"todo bug\">#587127017 Bug - Create Enterprise</a>"
    end
  end
end
