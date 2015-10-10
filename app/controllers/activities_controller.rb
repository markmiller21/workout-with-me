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

    # the following needs to be moved to methods so that it can be called anywhere
    potential_matches = []
    current_user.activities.each do |activity|
      activity.users.each do |user|
        if current_user != user
          potential_matches << user
        end
      end
    end
    for x in 0..potential_matches.length
      if Match.where(initiator_id: current_user.id, responder_id: potential_matches[x]) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: 1) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: -1) != []
        next
      else
        next_user_seen = potential_matches[x]
        binding.pry
        redirect_to match_path(next_user_seen)
        break
      end 
    end
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