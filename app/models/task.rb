class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :comments, :dependent => :destroy
  belongs_to :status
  belongs_to :type

  validates :user, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
end
