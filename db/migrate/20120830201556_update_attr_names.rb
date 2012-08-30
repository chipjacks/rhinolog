class UpdateAttrNames < ActiveRecord::Migration
  def change
  	rename_column :runs, :pace, :pace_in_secs
  	rename_column :runs, :mins, :time_in_mins
  end
end
