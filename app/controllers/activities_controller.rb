class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    user = User.find_by(id: current_user.id) # should be current user
    chosen_activities = params[:name]
    if chosen_activities
      chosen_activities.each do |activity|
        if Activity.find_by(name: activity.capitalize) != []
          activity = Activity.find_by(name: activity.capitalize)
        else
          activity = Activity.create(name: activitiy.capitalize)
        end
        user.activities << activity
      end
    else
      flash[:error] = "Must choose at least 1 activity"
      redirect_to activities_path
    end
    next_user_seen = User.find(3) #temporary patch to make mark the first match! ALWAYS!
    redirect_to match_path(next_user_seen)
  end








#1.Need to find all of the users that have same exact activities
#2.Then need to find the ones that have less in commmon and repeat pattern
#3.With ones with same activitiy,find the user who contains all those similar activities and redirect to them
#4.Create that possible match
#5.So we the accept value to 2, and create a condition where you can't redirect to anyone with an accepted value of 2
#6.

private

def params_activity
  params.require(:activity).permit(:name)
end

end