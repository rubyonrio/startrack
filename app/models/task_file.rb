class TaskFile < ActiveRecord::Base
  image_accessor :file
  belongs_to :task
end
