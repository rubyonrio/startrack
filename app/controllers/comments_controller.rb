class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      @task.watchers << current_user unless @task.watchers.include?(current_user)
      notify_comment(@comment)
      redirect_to @task, notice: 'Comment was successfully created.'
    else
     redirect_to @task, alert: 'Comment was not created.'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to task_url(@comment.task), alert: 'Comment was successfully deleted.'
  end

  def notify_comment(comment)
    unless @task.watchers.nil?
      @task.watchers.each do |watcher|
        CommentMailer.comment_notification(watcher, comment).deliver
      end
    end
  end
end
