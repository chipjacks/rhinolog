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
	attr_accessible :date_text, :distance, :feel, :effort, :pace_text, :time_text, 
						:notes, :rhinoGrid
	belongs_to :user

	validates :user_id, presence: true
	# validates :distance, presence: true
	# validates :time_in_secs, presence: true
	# validates :pace_in_secs, presence: true

	default_scope order: 'runs.date ASC'

	attr_writer :pace_text, :time_text

	before_validation :save_pace_text, :save_time_text, :complete_fields
	validate :check_pace_text, :check_time_text, :check_relationships, :check_feel_effort, 
			:check_distance

	def date_text=(date)
		self.date = Chronic.parse(date).to_s if date.present?
	end

	def date_text
		Chronic.parse(date).strftime("%m/%d") if date
	end

	def time_text
		if @time_text
			@time_text
		elsif time_in_secs
			(time_in_secs/60).round
		end
	end

	# def time_text=(time)
	#   self.time_in_secs = ChronicDuration.parse(time) if time.present?
	# end

	def rhinoGrid
		3 * self.feel + self.effort - 3 if feel.present? && effort.present?
	end

	def rhinoGrid=(num)
		if num.present?
			self.feel = ((10-num.to_f)/3).ceil
			self.effort = num.to_i % 3
			self.effort = 3 if num.to_i % 3 == 0
		end
	end

	def pace_text
		if @pace_text
			@pace_text
		elsif pace_in_secs
			ChronicDuration.output(pace_in_secs, :format => :chrono, units: 2)
		end
	end

	def save_pace_text
		if @pace_text.present?
			self.pace_in_secs = ChronicDuration.parse(@pace_text)
			if self.pace_in_secs < 220 #user meant minutes, not seconds
				self.pace_in_secs *= 60
			end
		end
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

	def save_time_text
		if @time_text.present?
			if !@time_text.include?('h') && !@time_text.include?('m')
				@time_text += ':00' unless @time_text.match(/.+:.+:.+/)
			end
			self.time_in_secs = ChronicDuration.parse(@time_text)
		end
	end

	def check_time_text
		if @time_text.present? && ChronicDuration.parse(@time_text).nil?
			errors.add :time_text, "cannot be parsed"
		end
	rescue ArgumentError
		errors.add :time_text, "is out of range"
	end

	def complete_fields
		if distance.present? && time_in_secs.present?
			self.pace_in_secs = time_in_secs / distance
		elsif time_in_secs.present? && pace_in_secs.present?
			self.distance = time_in_secs.to_f / pace_in_secs.to_f
		elsif distance.present? && pace_in_secs.present?
			self.time_in_secs = pace_in_secs * distance
		end
		if !self.date
			self.date = Time.zone.now.to_date
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

	def as_json(options={})
		super.as_json(options).merge({pace_text: pace_text, time_text: time_text})
	end
end
