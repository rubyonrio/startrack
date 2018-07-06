class TaskFile < ApplicationRecord
  dragonfly_accessor :file
  belongs_to :task
end
