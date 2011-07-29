class AddDescriptionHtmlToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :description_html, :text
  end
end
