class ChangeStatusInTasks < ActiveRecord::Migration
  def up
    change_table(:tasks) do |t|
      t.remove :status
    end

    change_table(:tasks) do |t|
      t.integer :status_id
    end
  end

  def down
    change_table(:tasks) do |t|
      t.remove :status_id
    end

    change_table(:tasks) do |t|
      t.integer :status
    end
  end
end
