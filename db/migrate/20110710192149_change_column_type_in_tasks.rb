class ChangeColumnTypeInTasks < ActiveRecord::Migration
  def up
    change_table(:tasks) do |t|
      t.remove :type
    end

    change_table(:tasks) do |t|
      t.integer :type_id
    end
  end

  def down
    change_table(:tasks) do |t|
      t.remove :type_id
    end

    change_table(:tasks) do |t|
      t.integer :type
    end
  end
end
