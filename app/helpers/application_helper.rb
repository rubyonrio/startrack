module ApplicationHelper
  def flash_messages
    flash.collect do |key, msg|
      content_tag :p, msg, :id => key, :class => "flash_messages"
    end.join.html_safe
  end
end
