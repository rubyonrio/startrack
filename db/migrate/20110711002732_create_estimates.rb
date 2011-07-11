class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.string :name

      t.timestamps
    end
  end
end
