class Comment < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  validates :description, :task, :user, :presence => true
  
  before_save :to_textile

  def to_textile
    self.description = RedCloth.new(self.description).to_html
  end
end
