class RunsController < ApplicationController
	respond_to :html, :json

	before_filter :authenticate_user!, only: [:create, :destroy]
  before_filter :correct_user,   only: [:update, :destroy]

  def index
    @run = current_user.runs.build(params[:run])
    @runs = current_user.runs.all
    @runs_by_date = @runs.group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def summary
    @run = current_user.runs.build(params[:run])
    begin
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
    rescue
      @date = Date.today
    end
    @runs = current_user.runs.all(
            :conditions => 
            {:date => @date.weeks_ago(7).beginning_of_week..@date.end_of_week})
    @runs_by_week = @runs.group_by{|r| r.date.beginning_of_week}
    @start_date = @date.beginning_of_week

  end

	def create
		@run = current_user.runs.build(params[:run])
    if @run.save
      flash[:success] = "Run created!" 
      redirect_to root_path({ date: @run.date })
    else
      params[:date] = @run.date ? @run.date : Date.today
      redirect_to root_path(request.parameters)
    end
  end

  def update
    @run = current_user.runs.find(params[:id])
	  @run.update_attributes(params[:run])
	  redirect_to root_path({ date: @run.date })
  end

  def show
  	@run = current_user.runs.find(params[:id])
    respond_with @run
  end

  def destroy
  	@run.destroy
  	redirect_to :back
  end

  private

    def correct_user
      @run = current_user.runs.find_by_id(params[:id])
      redirect_to root_url if @run.nil?
    end
end