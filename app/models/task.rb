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
      new_watchers = []
      new_watchers = params.collect(&:to_i)
      current_watchers = []
      current_watchers = self.watchers.collect(&:id).dup
      
      added_watchers  = new_watchers - current_watchers
      removed_watchers = current_watchers - new_watchers
      
      watchers_changes = {}
      watchers_changes[:added] = []
      watchers_changes[:removed] = []

      added_watchers.each do |added|
        watchers_changes[:added] << User.find(added)
      end

      removed_watchers.each do |removed|
        watchers_changes[:removed] << User.find(removed)
      end
      
      watchers_changes
    end
  end

end
