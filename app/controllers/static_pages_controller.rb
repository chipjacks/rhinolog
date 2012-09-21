class StaticPagesController < ApplicationController
  def home
  	if user_signed_in?
  		@run = current_user.runs.build
  		@date = params[:date] ? Date.parse(params[:date]) : Date.today
  		@runs = current_user.runs.all(
  						:conditions => 
  						{:date => @date.beginning_of_week..@date.end_of_week})
  	else
  		@session = user_session
  	end
  end
end