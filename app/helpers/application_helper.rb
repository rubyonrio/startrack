module ApplicationHelper
  include Rails.application.routes.url_helpers

  def link_to_logout
    link_to 'Logout', destroy_user_session_path, method: :delete
  end

  def flash_messages
    flash.collect do |key, msg|
      content_tag :p, msg, :id => key, :class => "flash_messages"
    end.join.html_safe
  end

  def app_version
    if ENV['APP_VERSION'].nil?
      %x[git describe --tags --abbrev=0]
    else
      ENV['APP_VERSION']
    end
  end
end