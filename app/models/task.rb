class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :responsible, :class_name => "User"
  belongs_to :status
  belongs_to :type
  belongs_to :estimate
  has_many :comments, :dependent => :destroy
  has_many :task_files, :dependent => :destroy
  has_and_belongs_to_many :watchers, :class_name => "User", :join_table => "tasks_watchers"

  accepts_nested_attributes_for :task_files, :reject_if => lambda { |a| a[:id].blank? and a[:file].blank? }, :allow_destroy => true

  validates :user, :status, :type, :name, :project, :duration_time, :presence => true

  before_save :normalize_description

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

  def normalize_description
    self.description = RedCloth.new(self.description).to_html rescue 'Invalid description format'
  end

  def get_watchers_changes(params)
    unless params.nil?
      current_watchers = []
      watchers.map{ |watch| current_watchers << watch.id.to_s}

      added_watchers = params - current_watchers
      removed_watchers = current_watchers - params

      watchers_changes = {}
      watchers_changes[:added] = []
      watchers_changes[:removed] = []

      added_watchers.each do |add|
        watchers_changes[:added] << add.to_i
      end

      removed_watchers.each do |remove|
        watchers_changes[:removed] << remove.to_i
      end


    end
      watchers_changes
  end

  def get_changes_names(changes)
    field = {:responsible_id => User, :status_id => Status, :type_id => Type, :estimate_id => Estimate}

    field.each do |key , value|
      old_name = "None yet"
      new_name = "None yet"

      if changes[key]
        if changes[key].first
          old_name = value.find(changes[key].first).name
        end
        if changes[key].last
          new_name = value.find(changes[key].last).name
        end
      end
      changes[key] = [old_name, new_name]
    end
    changes
  end

  def start_work
    self.start_time = Time.now
    self.save
  end

  def stop_work
    self.duration_time = self.duration_time + ((Time.now.to_i - start_time.to_datetime.to_i) / 60)
    self.start_time = nil
    self.save
  end
end
