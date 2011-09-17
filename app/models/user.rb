class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :url_image

  has_many :comments
  has_and_belongs_to_many :projects
  has_many :tasks
  has_and_belongs_to_many :tasks, :join_table => "tasks_watchers"

  validates :name,  :presence => true
end
