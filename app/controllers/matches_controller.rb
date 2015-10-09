class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
  end

  def create
    existing_match = Match.find_by(responder_id: 2, initiator_id:params[:match][:responder_id])
    if existing_match
      flash[:match] = "You have been matched!"
      existing_match.update_attributes(accepted: 1)
    else
      Match.create(responder_id: params[:match][:responder_id],initiator_id: 2)
    end
    potenital_users = []
    Users.all.each  do |potential_match|
      current_user.activities.each do |curr_user_activity|
        potential_match.activities.each do |pot_user_activity|
          if pot_user_activity.name == curr_user_activity.name
            potential_users.push(potential_match)
          end
        end
      end
    end
    hash = Hash.new(0)
    potential_users.each{|key| hash[key] += 1}
    hash.sort_by {|key, value| value}


    redirect_to match_path(potential_match)
  end
end

#1. Find next potential_match
#2. Need to find users with same amount of sport similarties
#3. Need to first