class ApplicationController < ActionController::Base

  protect_from_forgery
  before_filter :check_user

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      projects_url
    else
      root_url
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
    if user_signed_in?
      @responsibles = User.without(current_user).all_not_guest
    else
      @responsibles = User.all_not_guest
    end
  end

  def check_user
    if user_signed_in?
      @active_user = current_user
    else
      @active_user = User.where(:email => "guest@startrack.com").first
    end
  end
end
