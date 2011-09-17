module ApplicationHelper
  def flash_messages
    flash.collect do |key, msg|
      content_tag :p, msg, :id => key, :class => "flash_messages"
    end.join.html_safe
  end

  def app_version
    %x[git describe --tags --abbrev=0]
  end
end
