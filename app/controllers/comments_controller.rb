class CommentsController < ApplicationController

  def create
    @task = project.tasks.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    @comment.user = @active_user

    if @comment.save
      @task.watchers << @active_user unless @task.watchers.include?(@active_user)
      notify_comment(@comment)
      redirect_to project_task_path(project,@task), notice: 'Comment was successfully created.'
    else
      redirect_to project_task_path(project,@task), alert: 'Comment was not created.'
    end
  end

  def destroy
    task = project.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:id])
    @comment.destroy
    redirect_to project_task_path(project, @comment.task), alert: 'Comment was successfully deleted.'
  end

  def notify_comment(comment)
    recipients = ""
    unless @task.watchers.nil?
      @task.watchers.map { |watcher| recipients << "#{watcher.email}," }
      CommentMailer.comment_notification(recipients, comment).deliver
    end
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  end
end
