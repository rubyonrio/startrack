class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :status
  belongs_to :type
  belongs_to :estimate
  has_many :comments, :dependent => :destroy

  validates :user, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
end
