require 'spec_helper'

describe TasksHelper do
  let(:project) { projects(:first_journey) }
  let(:task) { tasks(:create_enterprise) }

  describe "link_to_show_task" do
    it "should return a link ti show task" do
      helper.link_to_show_task(project, task).should == "<a href=\"#{project_task_path(project,task)}\" class=\"todo bug\">##{task.id} #{task.type.name} - #{task.name}</a>"
    end
  end

  describe "time tracker" do
    it "should return a link to start the timer" do
      helper.link_to_time_track(project, task).should == "<a href=\"#{start_project_task_path(project,task)}\" class=\"timer\" data-remote=\"true\"><img alt=\"Ico-timer\" class=\"icon\" src=\"/assets/ico-timer.png\" />#{task.duration_time}m</a>"
    end

    it "should return a link to stop the timer" do
      task.start_time = Time.now
      helper.link_to_time_track(project, task).should == "<a href=\"#{stop_project_task_path(project,task)}\" class=\"timer active\" data-remote=\"true\"><img alt=\"Ico-timer-active\" class=\"icon\" src=\"/assets/ico-timer-active.png\" />#{task.duration_time}m</a>"
    end
  end
end
