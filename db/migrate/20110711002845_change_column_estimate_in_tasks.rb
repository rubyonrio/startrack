class ChangeColumnEstimateInTasks < ActiveRecord::Migration
  def up
    change_table(:tasks) do |t|
      t.remove :estimate
    end

    change_table(:tasks) do |t|
      t.integer :estimate_id
    end
  end

  def down
    change_table(:tasks) do |t|
      t.remove :estimate_id
    end

    change_table(:tasks) do |t|
      t.integer :estimate
    end
  end
end
