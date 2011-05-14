class AddTaskFieldToComments < ActiveRecord::Migration
  def change
    add_column :comments, :task_id, :integer
    add_index :comments, :task_id
    
  end
end
