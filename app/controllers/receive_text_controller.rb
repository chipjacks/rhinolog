class ReceiveTextController < ApplicationController
  def index
    @message_body = params["Body"]
    @from_number = params["From"]

   #  if log_run(@message_body, @from_number)
	  #   @response = "Logged succesfully"
	  # else
	  # 	@response = "Unable to log run"
	  # end

	  respond_to do |format|
	    	format.html { render :layout => nil }
	  end
  end
end