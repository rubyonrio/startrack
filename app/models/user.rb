class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_and_belongs_to_many :projects
  has_many :tasks
  has_and_belongs_to_many :tasks, :join_table => "tasks_watchers"

#  validates :name,  :presence => true

  default_scope { order("name") }
  scope :without, lambda { |user| where("id <> ? ", user.id)}
end
