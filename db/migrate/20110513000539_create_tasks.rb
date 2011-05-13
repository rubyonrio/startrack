class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :estimate
      t.integer :status
      t.integer :type
      t.references :user
      t.references :story

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :story_id
  end
end
