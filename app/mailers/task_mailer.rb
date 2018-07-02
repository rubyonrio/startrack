class TaskMailer < ActionMailer::Base

  def task_notification(task_id, changes, watchers_changes_ids)
    @task = Task.find task_id
    recipients = ""
    @task.watchers.map { |watcher| recipients << "#{watcher.email}, " }
    recipients << @task.user.email
    @watchers_changes = {}
    @watchers_changes[:added] = []
    @watchers_changes[:removed] = []
    unless watchers_changes_ids.blank?
      unless watchers_changes_ids["added"].blank?
        watchers_changes_ids["added"].map{ |watcher_id| @watchers_changes[:added] << User.find(watcher_id.to_i) }
      end
      unless watchers_changes_ids["removed"].blank?
        watchers_changes_ids["removed"].map{ |watcher_id| @watchers_changes[:removed] << User.find(watcher_id.to_i) }
      end
    end
    @changes = changes
    mail(:to => recipients[0..-3], :subject => "[#{@task.project.name}] The task ##{@task.id} - #{@task.name} has been updated", :from => "startrack@example.com.br")
  end
end
