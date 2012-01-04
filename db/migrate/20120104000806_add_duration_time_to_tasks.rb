class AddDurationTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :duration_time, :integer, :null => false
  end
end
