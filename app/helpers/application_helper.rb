module ApplicationHelper

	def base_title
		"Mileage Bank"
	end

	#Returns the full title ona per-page basis.
	def full_title(page_title)
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

end
