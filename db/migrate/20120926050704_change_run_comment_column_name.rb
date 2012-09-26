class ChangeRunCommentColumnName < ActiveRecord::Migration
	def change
		rename_column :runs, :comment, :notes
	end
end
