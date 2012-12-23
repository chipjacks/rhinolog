class StaticPagesController < ApplicationController
  def home
  	if user_signed_in?
      if params[:run]
  		  @run = current_user.runs.build(params[:run])
        @run.save
      else
        @run = current_user.runs.build
      end
  		@date = params[:date] ? Date.parse(params[:date]) : Date.today
  		@runs = current_user.runs.all(
  						:conditions => 
  						{:date => @date.beginning_of_week..@date.end_of_week})
  	else
      @run = Run.new
  		@session = user_session
  	end
  end

  def help
  end

  def about
  end
end