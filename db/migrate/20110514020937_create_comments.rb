class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :story      
      t.text :description
      
      t.timestamps
    end
    add_index :comments, :story_id
  end
end
