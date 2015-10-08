class ActivitiesController < ApplicationController

  def new
    @activity = Activity.new
  end

  def create
    activity = Activity.create(params[:activity])
  end

  def show
  end

end