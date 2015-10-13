class ActivitiesController < ApplicationController

  def index
    @activities = Activity.new
  end

  def create
    chosen_activities = params[:name]
    if chosen_activities && params[:user]
      chosen_activities.each do |activity|
        if Activity.find_by(name: activity)
          added_activity = Activity.find_by(name: activity)
        else
          added_activity = Activity.create(name: activity)
        end
        unless current_user.activities.include?(added_activity)
          current_user.activities << added_activity
        end
      end
      current_user.update_attributes(gender_preference: params[:user][:gender_preference])
      redirect_to initiate_match_path
    else
      flash[:error] = "Must choose at least 1 activity/preference"
      redirect_to activities_path
    end
  end

  def destroy
    activity = Activity.find_by(id: params[:id])
    current_user.activities.delete(activity)
    redirect_to edit_user_path(current_user)
  end

end