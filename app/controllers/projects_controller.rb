class ProjectsController < InheritedResources::Base
  before_filter :authenticate_user!
  respond_to :html
  actions :all

  def index
  end

  def show
    show! do
      @tasks = @project.tasks.all
      @task_todo = @project.tasks.todo
      @task_scheduled = @project.tasks.scheduled
      @task_current = @project.tasks.current
      @task_done = @project.tasks.done
    end
  end

  protected
  def begin_of_association_chain
    @project = current_user.projects.where(id: params[:id]).first
    @projects = current_user.projects if current_user.projects.any?
  end
end
