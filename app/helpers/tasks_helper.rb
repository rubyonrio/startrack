module TasksHelper
  def link_to_show_task(project, task)
    link_to "##{task.id} #{task.type.name} - #{task.name}", project_task_path(project,task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end

  def show_task_description(task)
    task.description_html? ? task.description_html.html_safe : task.description
  end
end
