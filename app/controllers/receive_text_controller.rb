include ReceiveTextHelper

class ReceiveTextController < ApplicationController
  def index
    @message_body = params["Body"]
    @from_number = params["From"].slice(2..11)

		if !(dude = User.find_by_phone(@from_number))
    	@response = "Account not found, please register your phone number at rhinolog.net"
    else
    	run_data = parse_body(@message_body)

    	newrun = dude.runs.build(run_data[:data])

	    if newrun.valid?
	    	newrun.save!
		    @response = "Logged succesfully. Date: #{newrun.date.strftime("%-m/%d")}, 
		    							distance: #{sprintf("%g", newrun.distance)}, 
		    							time: #{newrun.time_text}, pace: #{newrun.pace_text}"
		  else
		  	@response = "Unable to log run. "
		  	if run_data[:errors].empty?
		  		@response += "Not enough data: need data for two of distance, time, and pace."
		  	else
		  		@response += "Unable to parse "
		  		@response += run_data[:errors].join(", ")
		  		@response += "."
		  	end
		  end
    end

	  respond_to do |format|
	    	format.html { render :layout => nil }
	  end
  end
end