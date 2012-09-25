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

	def list_runs(runs)
		str = ""
		runs.each do |run|
			str += "#{run.distance}, TIME: #{run.time_text}, 
					PACE: #{run.pace_text}\n"
		end
		str
	end

end