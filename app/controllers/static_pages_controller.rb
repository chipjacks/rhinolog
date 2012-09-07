class StaticPagesController < ApplicationController
  def home
  	if user_signed_in?
  		@run = current_user.runs.build
  		@runs = current_user.runs
  	end
  end
end
