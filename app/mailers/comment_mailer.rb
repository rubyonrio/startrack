class CommentMailer < ActionMailer::Base
  include Resque::Mailer

  def comment_notification(comment_id)
    @comment = Comment.find comment_id
    @task = @comment.task
    recipients = ""
    @task.watchers.map { |watcher| recipients << "#{watcher.email}," }

    mail(:to => recipients, :subject => "[#{@comment.task.project.name}] #{@comment.user.name} made a new comment on ##{@comment.task.id} - #{@comment.task.name}", :from => "startrack@example.com.br")
  end
end
