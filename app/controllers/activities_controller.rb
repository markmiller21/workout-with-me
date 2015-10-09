class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
  end

  def new
  end

  def create
    activity = User.find(1).activities.create(name: params[:activity][:name])
  end

end