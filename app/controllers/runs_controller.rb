class RunsController < ApplicationController
	respond_to :html, :json

	def create
		@run = current_user.runs.build(params[:run])
		if @run.save
			flash[:success] = "Run created!"
			redirect_to root_path
		else
			render 'static_pages/home'
		end
  end

  def update
  	@run = current_user.runs.find(params[:id])
	  @run.update_attributes(params[:run])
	  respond_with @run
  end

  def show
  	@run = current_user.runs.find(params[:id])
  end

  def destroy
  end
end