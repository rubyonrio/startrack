class CommentMailer < ActionMailer::Base
  def comment_notification(watcher, comment)
    @task = comment.task
    @watcher = watcher
    @comment = comment
    mail(:to => watcher.email, :subject => "[#{@task.project.name}] New comment on ##{@task.id} - #{@task.name}", :from => "startrack@example.com.br")
  end 
end
