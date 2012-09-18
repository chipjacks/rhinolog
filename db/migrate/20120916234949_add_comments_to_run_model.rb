class AddCommentsToRunModel < ActiveRecord::Migration
  def change
  	add_column :runs, :comment, :text
  end
end
