require 'resque'

redis_config = YAML.load_file(File.join(File.dirname(__FILE__),"../redis.yml"))
Resque.redis = redis_config[Rails.env]

require 'resque_scheduler'
Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_schedule.yml'))

require 'resque/status_server'

require 'resque/job_with_status'
Resque::Status.expire_in = (24 * 60 * 60) # 24hrs in seconds

# Base class for all import files
require "#{Rails.root}/app/jobs/job_base.rb"

Dir["#{Rails.root}/app/jobs/*.rb"].sort.each { |file| require file }
