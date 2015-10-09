class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    user = User.find_by(id: 1) # should be current user
    chosen_activities = params[:name]
    chosen_activities.each do |activity|
      user.activities.find_or_create_by(name: activity)
    end
    redirect_to match_path(User.all.sample.id)
  end

  private

  def params_activity
    params.require(:activity).permit(:name)
  end

end