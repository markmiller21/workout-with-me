class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    user = User.find_by(id: 1) # should be current user
    user.activities.create(name: params[:activities][:name])
  end

  private

  def params_activity
    params.require(:activity).permit(:name)
  end

end