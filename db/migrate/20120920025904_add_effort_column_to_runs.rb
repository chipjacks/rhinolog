class AddEffortColumnToRuns < ActiveRecord::Migration
  def change
  	add_column :runs, :effort, :integer, default: 2
  end
end
