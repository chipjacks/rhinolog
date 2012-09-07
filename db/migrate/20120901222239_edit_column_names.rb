class EditColumnNames < ActiveRecord::Migration
	def change
		rename_column :runs, :time_in_mins, :time_in_secs
	end
end
