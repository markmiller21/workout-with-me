class ActivitiesController < ApplicationController

  def new
    @activity = Activity.new
  end

  def create
    activity = Activity.create(params[:activity])
    redirect_to activities_path
  end

  def show
    @activities = Activity.all
  end

end