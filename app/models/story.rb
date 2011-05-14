class Story < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :project
  has_many :comment
  
  validates :name,  :presence => true
end
