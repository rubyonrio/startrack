class ProjectsController < ApplicationController

  before_filter :check_public, :only => [:show, :edit, :update, :destroy]
  before_filter :load_users, :load_estimates, :load_status, :load_types, :only => [:show]

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
    @users = User.without(current_user)
  end

  def edit
    @users = User.without(current_user)
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

  def check_public
    @project = Project.find(params[:id])
    unless @project.public
      authenticate_user!
      @project = current_user.projects.find(params[:id])
    end
  end
end
