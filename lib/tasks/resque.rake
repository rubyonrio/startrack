require 'resque/tasks'

task "resque:setup" => :environment

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'resque_scheduler/tasks'
