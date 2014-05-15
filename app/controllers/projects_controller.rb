class ProjectsController < ApplicationController
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]
  before_filter :load_users, :load_estimates, :load_status, :load_types, :only => [:show]
  before_filter :load_other_users, :only => [:new, :edit]

  def index
    @projects = current_user.projects
  end

  def show
    @new_task = @project.tasks.new
    @tasks = @project.tasks.all
    @task_todo = @project.tasks.todo.order("updated_at DESC")
    @task_scheduled = @project.tasks.scheduled.order("updated_at DESC")
    @task_current = @project.tasks.current.order("updated_at DESC")
    @task_done = @project.tasks.done.order("updated_at DESC")
  end

  def new
    @project = current_user.projects.build
  end

  def edit
  end

  def create
    @project = Project.new(params[:project])
    @project.users << current_user
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: :new
    end
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end

  private

  def load_project
    @project = current_user.projects.find(params[:id])
  end

  def load_other_users
    @users = User.without(current_user)
  end
end
