class AddTimeTrackToProject < ActiveRecord::Migration
  def change
    add_column :projects, :time_track, :boolean
  end
end
