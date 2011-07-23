module ProjectsHelper

  def link_to_show_task(task)
    link_to "##{task.id} #{task.show_type_name} - #{task.name}", task_path(task), :class => "#{task.show_status_name}   #{task.type.name.parameterize unless task.type.nil?}"
  end
end
