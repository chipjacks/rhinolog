class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@runs = current_user.runs
  	end
  end
end
