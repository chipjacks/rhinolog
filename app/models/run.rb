# == Schema Information
#
# Table name: runs
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  date         :date
#  time_in_mins :integer
#  distance     :decimal(5, 2)
#  pace_in_secs :integer
#  feel         :integer          default(2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Run < ActiveRecord::Base
  attr_accessible :date, :distance, :feel, :pace, :time
  belongs_to :user

  validates :user_id, presence: true
  validates :date, presence: true
  validates :distance, presence: true
  validates :pace_in_secs, presence: true
  validates :time_in_mins, presence: true

  default_scope order: 'runs.date DESC'

  def time
  	sprintf("%d:%02d", time_in_mins/60, time_in_mins%60) if time_in_mins
  end

  def time=(time)
    self.time_in_mins = Time.parse(time).seconds_since_midnight/60 if time.present?
  end

  def pace
  	sprintf("%d:%02d", pace_in_secs/60, pace_in_secs%60) if pace_in_secs
  end

  def pace=(time)
  	pace_in_secs = Time.parse(time).seconds_since_midnight if time.present?
  end
end
