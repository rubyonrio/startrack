class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :html
  actions :all

  def index
    @projects = current_user.projects
  end

  def show
    show! do
      @project = Project.find(params[:id])
      @tasks = @project.tasks.all
      @task_todo = @project.tasks.todo
      @task_scheduled = @project.tasks.scheduled
      @task_current = @project.tasks.current
      @task_done = @project.tasks.done
    end
  end

  def new
    @project = current_user.projects.build
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.build(params[:project])
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
end
