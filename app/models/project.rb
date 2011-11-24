class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tasks, :dependent => :destroy

  validates :name,  :presence => true
  validates_length_of :users, :minimum => 1
end
