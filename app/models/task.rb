class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments, :dependent => :destroy
end
