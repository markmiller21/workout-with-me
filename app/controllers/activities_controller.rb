class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    user = User.find_by(id: current_user.id) # should be current user
    chosen_activities = params[:name]
    if chosen_activities
      chosen_activities.each do |activity|
        if Activity.find_by(name: activity)
          activity = Activity.find_by(name: activity)
        else
          activity = Activity.create(name: activity)
        end
        user.activities << activity
      end
      next_user_seen = User.find(3) #temporary patch to make mark the first match! ALWAYS!
      redirect_to match_path(next_user_seen)
    else
      flash[:error] = "Must choose at least 1 activity"
      redirect_to activities_path
    end

  end

private

def params_activity
  params.require(:activity).permit(:name)
end

end