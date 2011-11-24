class CommentMailer < ActionMailer::Base
  def comment_notification(recipients, comment)
    @comment, @task = comment, comment.task
    mail(:to => recipients, :subject => "[#{@task.project.name}] #{@comment.user.name} made a new comment on ##{@task.id} - #{@task.name}", :from => "startrack@example.com.br")
  end
end
