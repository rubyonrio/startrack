module TasksHelper
  def link_to_show_task(project, task)
    link_to "##{task.id} #{task.type.name} - #{task.name}", project_task_path(project,task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end

  def link_to_time_track(project, task)
    if task.start_time.nil?
      link_to start_project_task_path(project, task), :class => "timer", :remote => true do
        image_tag("ico-timer.png", :class => "icon")+
        "#{task.duration_time}m"
      end
    else
      link_to stop_project_task_path(project, task), :class => "timer active", :remote => true do
        image_tag("ico-timer-active.png", :class => "icon")+
        "#{task.duration_time}m"
      end
    end
  end
end
