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

    potential_users = current_user.activities.map do |activity|
    Activity.find_by(name: activity.name).users
    end
    binding.pry
      redirect_to activities_path
  end



  private

  def params_activity
    params.require(:activity).permit(:name)
  end

end