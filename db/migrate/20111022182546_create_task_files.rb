class CreateTaskFiles < ActiveRecord::Migration
  def change
    create_table :task_files do |t|
      t.string :file_uid
      t.string :file_name
      t.string :description
      t.references :task
      t.timestamps
    end
  end
end
