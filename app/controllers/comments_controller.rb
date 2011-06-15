class CommentsController < ApplicationController

  def new
    @projects = Project.find(params[:project_id])
    @tasks = @projects.tasks.find(params[:task_id])
    @comment = @tasks.comments.new
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: [:project, :task, @comment], status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: [:project, :task, @comment].errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :ok }
    end
  end
end
