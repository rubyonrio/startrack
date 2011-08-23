class TasksWatchers < ActiveRecord::Migration
  def self.up
    create_table :tasks_watchers, :id => false do |t|
      t.references :user, :null => false
      t.references :task, :null => false
    end
  end

  def self.down
    drop_table :tasks_watchers
  end
end
