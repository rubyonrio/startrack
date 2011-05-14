class Story < ActiveRecord::Base
  has_many :task
  belongs_to :project
  
  validates :name,  :presence => true
end
