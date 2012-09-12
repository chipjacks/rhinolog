module StaticPagesHelper

	def disp_date_range(from, to)
		if from.month == to.month
			"#{from.strftime("%b %-d")} - #{to.strftime("%-d")}"
		else
			"#{from.strftime("%b %-d")} - #{to.strftime("%b %-d")}"
		end
	end

end
