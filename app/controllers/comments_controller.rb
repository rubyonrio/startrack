class CommentsController < ApplicationController

  def create
    @task = project.tasks.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      @task.watchers << current_user unless @task.watchers.include?(current_user)
      CommentMailer.comment_notification(@comment.id).deliver!
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
  
  private
    def project
      @project ||= Project.find(params[:project_id])
    end
end
