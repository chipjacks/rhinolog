# == Schema Information
#
# Table name: runs
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  date         :date
#  time_in_secs :integer
#  distance     :decimal(5, 2)
#  pace_in_secs :integer
#  feel         :integer          default(2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  comment      :text
#  effort       :integer          default(2)
#

class Run < ActiveRecord::Base
  attr_accessible :date, :distance, :feel, :effort, :pace_text, :time_text, 
            :comment, :rhinoGrid
  belongs_to :user

  validates :user_id, presence: true
  # validates :distance, presence: true
  # validates :time_in_secs, presence: true
  # validates :pace_in_secs, presence: true

  default_scope order: 'runs.date ASC'

  attr_writer :pace_text

  before_validation :save_pace_text,  :complete_fields
  validate :check_pace_text, :check_relationships, :check_feel_effort, 
      :check_distance

  def time_text
  	ChronicDuration.output(time_in_secs, :format => :short) if time_in_secs
  end

  def time_text=(time)
    self.time_in_secs = ChronicDuration.parse(time) if time.present?
  end

  def rhinoGrid
    3 * self.feel + self.effort - 3 if feel.present? && effort.present?
  end

  def rhinoGrid=(num)
    if num.present?
      self.feel = (num.to_f/3).ceil
      self.effort = num.to_i % 3
      self.effort = 3 if num.to_i % 3 == 0
    end
  end

  def pace_text
    if @pace_text
      @pace_text
    elsif pace_in_secs
      ChronicDuration.output(pace_in_secs, :format => :short)
    end
  end

  def save_pace_text
  	self.pace_in_secs = ChronicDuration.parse(@pace_text) if @pace_text.present?
  end

  def check_pace_text
    # if !@pace_text.present?
    #   errors.add :pace_text, "can't be blank"
    if @pace_text.present? && ChronicDuration.parse(@pace_text).nil?
      errors.add :pace_text, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :pace_text, "is out of range"
  end

  def complete_fields
    if distance.present? && time_in_secs.present?
      self.pace_in_secs = time_in_secs / distance
    elsif time_in_secs.present? && pace_in_secs.present?
      self.distance = time_in_secs / pace_in_secs
    elsif distance.present? && pace_in_secs.present?
      self.time_in_secs = pace_in_secs * distance
    end
    if !self.date
      self.date = Date.today
    end
  end

  def check_relationships
    if !distance || !time_in_secs || !pace_in_secs 
      self.errors.add(:base, "Not enough information to log a run")
    end
  end

  def check_feel_effort
    unless (1..3) === feel
      self.errors.add(:feel, "is invalid")
    end
    unless (1..3) === effort
      self.errors.add(:effort, "is invalid")
    end
  end

  def check_distance
    if distance == 0
      self.errors.add(:distance, "is invalid")
    end
  end
end
