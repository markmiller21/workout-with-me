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
    next_potenital_match = Match.all.where(accepted: 0).sample.responder_id
    redirect_to match_path(next_potenital_match)
  end
end

#1. A user needs to find people he hasn't matched with it.
#2. So needs to find the 0.
#3. If the user gets a potential_match that he had a match with already
#4. Need to skip that user or reassign the potenital_match again
#5. Repeat process
#6.