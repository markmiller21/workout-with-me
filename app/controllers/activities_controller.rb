class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    user = User.find_by(id: current_user.id) # should be current user
    chosen_activities = params[:name]
    if chosen_activities
      chosen_activities.each do |activity|
        user.activities.find_or_create_by(name: activity)
      end
      redirect_to match_path(User.all.sample.id)
    else
      flash[:error] = "Must choose at least 1 activity"
      redirect_to activities_path
    end

    current_user_act_names = []
    current_user.activities.each do |activity|
      current_user_act_names.push(activity.name)
    end

    activities_in_db = []
    current_user_act_names.each do |activity_name|
      activities_in_db.push(Activity.where(name: activity_name))
    end

    potential_user = []
    activities_in_db.flatten.each do |pot_match|
      potential_user.push(pot_match.users)
    end


    user_id =[]
    potential_user.flatten.each do |user|
      user_id.push(user.id)
    end

    user_id.uniq!
    user_id.each do |id|
      current_user.initiator_matches.create(responder_id:id,accepted: 2)
    end

    redirect_to match_path(curr)
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