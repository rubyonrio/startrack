class ProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users, :id => false do |t|
      t.references :user, :null => false
      t.references :project, :null => false
    end
  end
end
