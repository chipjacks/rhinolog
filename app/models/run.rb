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
	attr_accessible :date_text, :distance, :feel, :effort, :pace_in_secs, :time_in_secs, 
						:notes, :rhinoGrid
	belongs_to :user

	before_validation :complete_fields
	validates :user_id, presence: true
	validates :date, presence: true
	# validates :distance, presence: true
	# validates :time_in_secs, presence: true
	# validates :pace_in_secs, presence: true

	default_scope order: 'runs.date ASC'

	def parse_text(f)
		if f[:date_text].present?
			self.date = Chronic.parse(f[:date_text])
		else
			self.date = Date.today
		end
		if f[:distance]
			self.distance = f[:distance].to_f
		end
		if f[:time_text]
			if !f[:time_text].include?('h') && !f[:time_text].include?('m')
        f[:time_text] += ':00' unless f[:time_text].match(/.+:.+:.+/)
      end
			self.time_in_secs = ChronicDuration.parse(f[:time_text])
		end
		if f[:pace_text]
			self.pace_in_secs = ChronicDuration.parse(f[:pace_text])
			if self.pace_in_secs < 220 #user meant minutes, not seconds
        self.pace_in_secs *= 60
      end
		end
		if f[:feel]
			self.feel = f[:feel]
		end
		if f[:effort]
			self.effort = f[:effort]
		end
		if f[:notes]
			self.notes = f[:notes]
		end
	end

	def complete_fields
    if distance.present? && time_in_secs.present?
      self.pace_in_secs = time_in_secs / distance
    elsif time_in_secs.present? && pace_in_secs.present?
      self.distance = time_in_secs.to_f / pace_in_secs.to_f
    elsif distance.present? && pace_in_secs.present?
      self.time_in_secs = pace_in_secs * distance
    end
  end

	def date_text=(date)
		self.date = Chronic.parse(date).to_s if date.present?
	end

	def date_text
		Chronic.parse(date).strftime("%m/%d") if date
	end

	def time_text
		ChronicDuration.output(time_in_secs/60, format: :chrono) if time_in_secs
	end

	def pace_text
		ChronicDuration.output(pace_in_secs, format: :chrono) if pace_in_secs
	end

	def as_json(options={})
		super.as_json(options).merge({pace_text: pace_text, time_text: time_text})
	end
end
