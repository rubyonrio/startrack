class CommentMailer < ActionMailer::Base
  include Resque::Mailer

  def comment_notification(recipients, comment)
    @comment, @task = comment, comment.task

    mail(:to => recipients, :subject => "[#{comment.task.project.name}] #{comment.user.name} made a new comment on ##{comment.task.id} - #{comment.task.name}", :from => "startrack@example.com.br")
  end
end
