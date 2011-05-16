class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.references :task

      t.timestamps
    end
    add_index :comments, :task_id
  end
end
