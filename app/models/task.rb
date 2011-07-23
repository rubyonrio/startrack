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

  scope :todo, where(:status_id => 1)
  scope :scheduled, where(:status_id => 2)
  scope :current, where(:status_id => 3)
  scope :done, where(:status_id => 4)

  def show_type_name
    self.type.name rescue 'no-type'
  end

  def show_status_name
    self.status.name.parameterize rescue 'no-status'
  end
end
