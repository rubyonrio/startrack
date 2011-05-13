class HomeController < ApplicationController
  def index
    @user_projects = current_user.projects
  end
end
