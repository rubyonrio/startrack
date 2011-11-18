module ApplicationHelper
  def flash_messages
    flash.collect do |key, msg|
      content_tag :p, msg, :id => key, :class => "flash_messages"
    end.join.html_safe
  end

  def app_version
    ENV['APP_VERSION']
  end
end
