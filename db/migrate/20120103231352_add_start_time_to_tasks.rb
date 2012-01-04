class AddStartTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :start_time, :datetime
  end
end
