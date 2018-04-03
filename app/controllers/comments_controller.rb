class CommentsController < ApplicationController

  def create
    @task = project.tasks.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      @task.watchers << current_user unless @task.watchers.include?(current_user)
      Resque.enqueue(CommentMail, @comment.id)
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

    def comment_params
      params.require(:comment).permit!
    end
end
