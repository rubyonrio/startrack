class TaskFile < ActiveRecord::Base
  dragonfly_accessor :file
  belongs_to :task
end
