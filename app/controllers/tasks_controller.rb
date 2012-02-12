class TasksController < ApplicationController

  respond_to :js, :only => [:change_status, :start, :stop]
  before_filter :load_users, :load_estimates, :load_status, :load_types, :only => [:new, :create, :edit, :update]
  before_filter :load_task, :only => [:show, :edit, :update, :destroy, :change_status, :start, :stop]

  def show
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def edit
    project
  end

  def create
    @task = project.tasks.build(params[:task])
    @task.user = current_user

    if @task.save
      redirect_to @project, notice: 'Task was successfully created.'
    else
      flash[:error] = 'Err... sorry, but something is wrong. :/'
      redirect_to project_url(@task.project)
    end
  end

  def update
    @watchers_changes = @task.get_watchers_changes(params[:task][:watcher_ids])

    @task.attributes = params[:task]
    @task_changes = @task.get_changes_names(@task.changes)

    if @task.save
      notify_changes(@task, @task_changes, @watchers_changes)
      redirect_to project_task_path(project,@task), notice: 'Task was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to project_url(@task.project)
  end

  def change_status
    @task.update_attributes(:status_id => params[:status_id])

    respond_with @task
  end

  def start
    @task.start_work

    respond_with @task
  end

  def stop
    @task.stop_work

    respond_with @task
  end

  private

  def load_task
    @task = project.tasks.find(params[:id])
  end

  def project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def notify_changes(task, changes, watchers_changes)
    unless @task.watchers.nil?
      recipients = ""
      @task.watchers.map { |watcher| recipients << "#{watcher.email}," }
      TaskMailer.task_notification(recipients, task, changes, watchers_changes).deliver
    end
  end
end
