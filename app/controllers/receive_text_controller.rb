include ReceiveTextHelper

class ReceiveTextController < ApplicationController
  def index
    @message_body = params["Body"]
    @from_number = params["From"].slice(2..11)

		if !(dude = User.find_by_phone(@from_number))
    	@response = "Account not found, please register your phone number at Rhinolog.net"
    else
    	run_data = parse_body(@message_body)

    	newrun = dude.runs.build(run_data[:data])

    	if run_data[:errors].empty?
    		if run_data[:date_text]
    			newrun.date = Chronic.parse(run_data[:date_text], context: :past).to_date
    		else
    			newrun.date = Date.today
    		end
    		newrun.save!
    		@response = "Logged succesfully - date: "
    		@response += newrun.date.strftime("%-m/%d")}
    		if newrun.distance
    			@response += ", distance: #{sprintf("%g", newrun.distance)}"
    		end
    		if newrun.time_in_secs
    			@response += ", time: #{ChronicDuration.output(newrun.time_in_secs, :format => :short)}"
    		end
    		if newrun.pace_in_secs
    		 @response += ", pace: #{ChronicDuration.output(newrun.pace_in_secs, :format => :short)}"
    		end
    	else
    		@response = "Unable to log run. Couldn't parse "
    		@response += run_data[:errors].join(", ")
		  	@response += "."
	    end

	   #  if newrun.valid?
	   #  	newrun.save!
		  #   @response = "Logged succesfully - date: #{newrun.date.strftime("%-m/%d")}, distance: #{sprintf("%g", newrun.distance)}, time: #{ChronicDuration.output(newrun.time_in_secs, :format => :short)}, pace: #{ChronicDuration.output(newrun.pace_in_secs, :format => :short)}"
		  # else
		  # 	@response = "Unable to log run. "
		  # 	if run_data[:errors].empty?
		  # 		@response += "Not enough data: need data for two of distance, time, and pace. Example: 'date 9/25, distance 12, pace 7m30s, feel good, effort easy'"
		  # 	else
		  # 		@response += "Unable to parse "
		  # 		@response += run_data[:errors].join(", ")
		  # 		@response += "."
		  # 	end
		  # end
    end

	  respond_to do |format|
	    	format.html { render :layout => nil }
	  end
  end
end