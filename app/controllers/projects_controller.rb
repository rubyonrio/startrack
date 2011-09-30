class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :member_of?, :only => "show"

  def index
    @projects = current_user.projects
  end

  def show
    @project = Project.find(params[:id])
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
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.build(params[:project])
    @project.users << current_user
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @project = current_user.projects.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    redirect_to projects_url
  end

  def member_of?
    @project = Project.find(params[:id])
    unless @project.users.include?(current_user)
      redirect_to root_path, :alert => "You don't have permission to acess this project."
    end
  end
end

