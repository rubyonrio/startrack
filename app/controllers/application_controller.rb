class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :default_page_title

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      projects_url
    else
      root_url
    end
  end

  def default_page_title
    load_page_title(nil)
  end

  def load_page_title(local_info)
    if local_info.nil?
      @page_title = "Startrack - Agile based tracker"
    else
      @page_title = "#{local_info} - Startrack - Agile based tracker"
    end
  end
end
