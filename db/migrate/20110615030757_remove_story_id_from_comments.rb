class RemoveStoryIdFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :story_id
  end

  def down
    add_column :comments, :story_id, :integer
  end
end
