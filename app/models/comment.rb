class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  
  validates :task, :presence => true
  validates :user, :presence => true
end
