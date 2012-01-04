module TasksHelper
  def link_to_show_task(project, task)
    link_to "##{task.id} #{task.type.name} - #{task.name}", project_task_path(project,task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end

  def show_task_description(task)
    #TODO: Confirm if it make sense
    task.description_html? ? task.description_html.html_safe : task.description
  end

  def link_to_time_track(project, task)
    if task.start_time.nil?
      link_to("Start (#{task.duration_time}m)", start_project_task_path(project, task), :remote => true)
    else
      link_to("Stop (#{task.duration_time}m)", stop_project_task_path(project, task), :remote => true)
    end
  end

  def to_hours(minutes)
    if (minutes/60) > 0
      result = minutes/60
      return result
    end
  end
end
