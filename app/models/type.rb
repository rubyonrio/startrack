class Type < ApplicationRecord
  validates :name, :presence => true
  has_many :tasks
end
