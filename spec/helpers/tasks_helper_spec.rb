require 'rails_helper'

describe TasksHelper do
  let(:project) { create(:project, name: "First Journey") }
  let(:task) { create(:task, start_time: nil, project: project) }

  describe "link_to_show_task" do
    it "should return a link ti show task" do
      expect(helper.link_to_show_task(project, task)).to eq("<a class=\"todo bug\" href=\"#{project_task_path(project, task)}\">##{task.id} #{task.type.name} - #{task.name}</a>")
    end
  end

  describe "time tracker" do
    it "should return a link to start the timer" do
      expect(helper.link_to_time_track(project, task)).to eq("<a class=\"timer\" data-remote=\"true\" href=\"#{start_project_task_path(project,task)}\"><img class=\"icon\" src=\"/assets/ico-timer-318ddd204154ee04cd5e7a1bf3e33654dc6235d0c4149f9298335d57e902f6a1.png\" alt=\"Ico timer\" />#{task.duration_time}m</a>")
    end

    it "should return a link to stop the timer" do
      task.start_time = Time.now
      expect(helper.link_to_time_track(project, task)).to eq("<a class=\"timer active\" data-remote=\"true\" href=\"#{stop_project_task_path(project,task)}\"><img class=\"icon\" src=\"/assets/ico-timer-active-c5cdaef9ee353a2216c31c4d46eb28ad4ee097e9fdb7ba42bf9fcf3ede53651d.png\" alt=\"Ico timer active\" />#{task.duration_time}m</a>")
    end
  end
end
