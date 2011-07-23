class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :responsible, :class_name => "User"
  belongs_to :status
  belongs_to :type
  belongs_to :estimate
  has_many :comments, :dependent => :destroy

  validates :user, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
  validates :type, :presence => true
  validates :status, :presence => true

  scope :todo, joins(:status).where("statuses.name = 'TODO'")
  scope :scheduled, joins(:status).where("statuses.name = 'Scheduled'")
  scope :current, joins(:status).where("statuses.name = 'Current'")
  scope :done, joins(:status).where("statuses.name = 'Done'")

  def show_type_name
    self.type.name rescue 'no-type'
  end

  def show_type_parameterize_name
    self.type.name.parameterize rescue 'no-type'
  end

  def show_status_name
    self.status.name rescue 'no-status'
  end

  def show_status_parameterize_name
    self.status.name.parameterize rescue 'no-status'
  end
end
