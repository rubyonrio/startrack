class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  has_many :comment
end
