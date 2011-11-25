module TasksHelper
  def link_to_show_task(task)
    link_to "##{task.id} #{task.type.name} - #{task.name}", task_path(task),
      :class => "#{task.show_status_parameterize_name} #{task.show_type_parameterize_name}"
  end

  def show_task_description(task)
    task.description_html? ? task.description_html.html_safe : task.description
  end

  def link_to_remove_fields(name, f, file_id)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields('#{file_id}')", :class => "side-link")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :child_index => "new_#{association}")
    end
    link_to_function(name, "add_fields(\"#{association}\", \"#{escape_javascript(fields)}\")", :class => "button small add-image")
  end
end
