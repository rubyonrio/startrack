class AdjustDefaultTimeColumn < ActiveRecord::Migration
  def change
    change_column :tasks, :duration_time, :integer, default: 0
  end
end
