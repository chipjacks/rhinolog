module RunHelper

	def sum_distance(arr)
		sum = 0
		arr.each do |r|
			if r.distance
				sum += r.distance
			end
		end
		sum
	end

	def sum_time(arr)
		sum = 0
		arr.each do |r|
			if r.time_in_secs
				sum += r.time_in_secs
			end
		end
		sum
	end

	def avg_pace(arr)
		sum = 0
		count = 0
		arr.each do |r|
			if r.time_in_secs && r.pace_in_secs
				sum += r.pace_in_secs
				count += 1
			end
		end
		if count != 0
			(sum/count).round
		else
			nil
		end
	end

	def avg_effort(arr)
		sum = 0
		count = 0
		arr.each do |r|
			if r.effort && r.effort != 0
				sum += r.effort
				count += 1
			end
		end
		if count != 0
			sum.to_f/count
		else
			nil
		end
	end

	def avg_feel(arr)
		sum = 0
		count = 0
		arr.each do |r|
			if r.feel && r.feel != 0
				sum += r.feel
				count += 1
			end
		end
		if count != 0
			sum.to_f/count
		else
			nil
		end
	end

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