class TaskMailer < ActionMailer::Base
  #include Resque::Mailer

  def task_notification(recipients, task, changes, watchers_changes)
    @task, @changes, @watchers_changes = task, changes, watchers_changes
    mail(:to => recipients, :subject => "[#{@task.project.name}] The task ##{@task.id} - #{@task.name} has been updated", :from => "startrack@example.com.br")
  end
end
