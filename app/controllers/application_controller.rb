class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      projects_url
    else
      root_url
    end
  end
end
