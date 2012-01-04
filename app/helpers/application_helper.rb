module ApplicationHelper
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
