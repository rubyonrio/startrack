module TasksHelper
  def link_to_show_task(task)
    link_to "##{task.id} #{task.show_type_name} - #{task.name}", task_path(task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end
end
