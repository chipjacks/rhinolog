class ChangeFeelEffortDefaults < ActiveRecord::Migration
	def change
		change_column :runs, :feel, :integer, default: 0
		change_column :runs, :effort, :integer, default: 0
	end
end
