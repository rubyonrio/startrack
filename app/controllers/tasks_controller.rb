class TasksController < ApplicationController

  respond_to :js, :only => [:change_status, :start, :stop]
  before_action :load_users, :load_estimates, :load_status, :load_types, :only => [:new, :create, :edit, :update]
  before_action :load_task, :only => [:show, :edit, :update, :destroy, :change_status, :start, :stop]

  def show
    @comments = @task.comments.all
    @comment = @task.comments.new
  end

  def edit
    project
  end

  def create
    @task = project.tasks.build(task_params[:task])
    @task.user = current_user
    if @task.save
      redirect_to project_task_path(@task.project, @task), notice: 'Task was successfully created.'
    else
      flash[:error] = 'Err... sorry, but something is wrong. :/'
      redirect_to project_path(@task.project.id)
    end
  end

  def update
    @watchers_changes = @task.get_watchers_changes(task_params[:task][:watcher_ids])
    @task.attributes = task_params[:task]
    @task_changes = @task.get_changes_names(@task.changes)

    if @task.save
      Resque.enqueue(TaskMail, @task.id, @task_changes, @watchers_changes)
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
    status_id = Status.find_by_name(task_params[:status]).id

    @task.update_attributes(status_id: status_id)
    @task.save

    redirect_to projects_path(@task.project)
  end

  def start
    @task.start_work

    redirect_to project_task_path(@task.project, @task)
  end

  def stop
    @task.stop_work

    redirect_to project_task_path(@task.project, @task)
  end

  private

  def load_task
    @task = project.tasks.find(params[:id])
  end

  def project
    @project ||= current_user.projects.find(params[:project_id])
  end

  def task_params
    params.permit!
  end
end
