module RunHelper

	def color(num)
  	case num
		when 1
			"green"
		when 2
			"yellow"
		when 3
			"red"
		end
	end

	def feel_title(num)
		case num
		when 1
			"Good"
		when 2
			"Okay"
		when 3
			"Bad"
		end
	end

	def effort_title(num)
		case num
		when 1
			"Easy"
		when 2
			"Moderate"
		when 3
			"Hard"
		end
	end

	def list_runs(runs)
		str = ""
		runs.each do |run|
			str += "#{run.distance}, TIME: #{run.time_text}, 
					PACE: #{run.pace_text}\n"
		end
		str
	end

end