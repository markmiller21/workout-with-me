class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
  end

  def create
    existing_match = Match.find_by(responder_id: current_user.id, initiator_id:params[:match][:responder_id])
    if existing_match
      flash[:match] = "You have been matched!"
      existing_match.update_attributes(accepted: 1)
    else
      Match.create(responder_id: params[:match][:responder_id],initiator_id: current_user.id)
    end


end


#1. Find activities for the current_user
#2. Iterate over those activities
#3. Find all the users related to that specific activity