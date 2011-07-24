module TasksHelper
  def show_responsible_avatar(task)
    image_tag(avatar_url(task.responsible), :class => "avatar icon") unless task.responsible.nil?
  end

  def link_to_show_task(task)
    link_to "##{task.id} #{task.type.name} - #{task.name}", task_path(task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end
end
