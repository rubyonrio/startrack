class CommentMailer < ActionMailer::Base
  def comment_notification(watcher, comment)
    @watcher, @comment, @task = watcher, comment, comment.task
    mail(:to => watcher.email, :subject => "[#{@task.project.name}] New comment on ##{@task.id} - #{@task.name}", :from => "startrack@example.com.br")
  end 
end
