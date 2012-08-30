class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.date :date
      t.integer :mins
      t.decimal :distance, :precision => 5, :scale => 2
      t.integer :pace
      t.integer :feel, :default => 2

      t.timestamps
    end
    add_index :runs, [:user_id, :date]
  end
end
