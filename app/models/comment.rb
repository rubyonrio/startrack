class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :description, :task, :user, :presence => true
end
