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

  before_save :to_textile

  scope :todo, joins(:status).where("statuses.name = 'TODO'")
  scope :scheduled, joins(:status).where("statuses.name = 'Scheduled'")
  scope :current, joins(:status).where("statuses.name = 'Current'")
  scope :done, joins(:status).where("statuses.name = 'Done'")

  def show_responsible_name
    self.responsible.name rescue 'No responsible yet'
  end

  def show_estimate_name
    self.estimate.name rescue 'No estimative yet'
  end

  def show_type_parameterize_name
    self.type.name.parameterize
  end

  def show_status_parameterize_name
    self.status.name.parameterize
  end

  def to_textile
    self.description = RedCloth.new(self.description).to_html
  end
end
