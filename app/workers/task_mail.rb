class TaskMail
  @queue = :task_queue

  def self.perform(task_id, task_changes, watchers_changes_ids)
    TaskMailer.task_notification(task_id, task_changes, watchers_changes_ids).deliver
  end
end
