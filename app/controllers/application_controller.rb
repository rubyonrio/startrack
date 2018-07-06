class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      projects_path
    else
      root_path
    end
  end

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
end
