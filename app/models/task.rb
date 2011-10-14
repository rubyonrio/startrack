class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :responsible, :class_name => "User"
  belongs_to :status
  belongs_to :type
  belongs_to :estimate
  has_many :comments, :dependent => :destroy
  has_and_belongs_to_many :watchers, :class_name => "User", :join_table => "tasks_watchers"

  validates :user, :presence => true
  validates :project, :presence => true
  validates :name, :presence => true
  validates :type, :presence => true
  validates :status, :presence => true

  before_save :to_format

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

  def to_format
    self.description_html = RedCloth.new(self.description).to_html rescue ''
  end

  def get_watchers_changes(params)
    unless params.nil?
      new_watchers = User.find(params)
      current_watchers = User.find(self.watchers.collect(&:id).dup)
      watchers_changes = {}
      watchers_changes[:added] = new_watchers unless current_watchers.include?(new_watchers)
      watchers_changes[:removed] = current_watchers unless new_watchers.include?(current_watchers)
      watchers_changes
    end
  end

end
