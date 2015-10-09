class ActivitiesController < ApplicationController

  def index
    @activities = Activity.all
  end

  def new
  end

  def create
    activity = current_user.activities.create
  end

end