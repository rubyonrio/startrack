class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @task.watchers << current_user unless @task.watchers.include?(current_user)
        format.html { redirect_to @task, notice: 'Comment was successfully created.' }
        format.json { render json: [:task, @comment], status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: [:task, @comment].errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to task_url(@comment.task), alert: 'Comment was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
