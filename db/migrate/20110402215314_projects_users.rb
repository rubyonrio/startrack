class ProjectsUsers < ActiveRecord::Migration
  def self.up
    create_table :projects_users, :id => false do |t|
      t.references :user, :null => false
      t.references :project, :null => false
    end
  end

  def self.down
    drop_table :projects_users
  end
end
