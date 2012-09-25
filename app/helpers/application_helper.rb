module ApplicationHelper

	def base_title
		"Rhino Log"
	end

	#Returns the full title ona per-page basis.
	def full_title(page_title)
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def signed_in?
    !current_user.nil?
  end

  def shorten(string)
  	maxlength = 80
  	if string.length > maxlength
  		"#{string.slice(0, maxlength)}..."
  	else
  		string.slice(0, maxlength)
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

	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
