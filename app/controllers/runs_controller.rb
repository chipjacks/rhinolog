class RunsController < ApplicationController
	respond_to :html, :json

	before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :correct_user,   only: [:update, :destroy]

  def index
    @runs = Run.all
    @runs_by_date = @runs.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

	def create
		@run = current_user.runs.build(params[:run])
		if @run.save
			flash[:success] = "Run created!"
			redirect_to root_url
		else
      @runs = Run.all
    @runs_by_date = @runs.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
			render 'static_pages/home'
		end
  end

  def update
  	# @run = current_user.runs.find(params[:id])
	  @run.update_attributes(params[:run])
	  respond_with @run
  end

  def show
  	@run = current_user.runs.find(params[:id])
  end

  def destroy
  	# @run = current_user.runs.find(params[:id])
  	@run.destroy
  	redirect_to root_url
  end

  private

    def correct_user
      @run = current_user.runs.find_by_id(params[:id])
      redirect_to root_url if @run.nil?
    end
end