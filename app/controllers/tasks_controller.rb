class TasksController < ApplicationController
  before_filter :authenticate_user!

  before_filter :load_users, :load_estimates, :load_status, :load_types, :only => [:new, :create, :edit]

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.build(params[:task])
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @project, notice: 'Task was successfully created.' }
        format.json { render json: [:project, @task], status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: [:project, @task].errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])

    @current_watchers = @task.watchers
    @new_watchers = User.find(params[:task][:watcher_ids])
    watchers_changes(@current_watchers, @new_watchers)

    params[:task][:watcher_ids] ||= []
    @task.attributes = params[:task]
    @task_changes = @task.changes

    respond_to do |format|
      if @task.save
        notify_changes(@task, @task_changes, @watchers_changes)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_url(@task.project)
  end

  private

  def load_estimates
    @estimate = Estimate.all
  end

  def load_status
    @status = Status.all
  end

  def load_types
    @type = Type.all
  end

  def load_users
    @responsibles = User.all
  end

  def watchers_changes(current, new)
    added = []
    added << new unless current.include?(new)

    removed = []
    removed << current unless new.include?(current)

    @watchers_changes = [added, removed]
  end

  def notify_changes(task, changes, watchers_changes)
    unless @task.watchers.nil?
      @task.watchers.each do |watcher|
        TaskMailer.task_notification(watcher, task, changes, watchers_changes).deliver
      end
    end
  end

end
