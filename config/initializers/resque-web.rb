require 'yaml'
require 'resque'
require 'resque_scheduler'
require 'resque/status_server'
require 'resque/job_with_status'

Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))

# Resque-scheduler needs the classes to accept the "Queue now" feature...
# Base class for all import files
require "#{Dir.pwd}/app/jobs/job_base.rb"
Dir["#{Dir.pwd}/app/jobs/*.rb"].sort.each { |file| require file }
