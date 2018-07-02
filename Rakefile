#!/usr/bin/env rake
require File.expand_path('../config/application', __FILE__)

module TempFixForRakeLastComment
  def last_comment
    last_description
  end
end
Rake::Application.send :include, TempFixForRakeLastComment

Startrack::Application.load_tasks

