class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])

    @possible_match = Match.find_by(id: params[:id])
    @possible_user = User.find(@possible_match.responder_id)
  end

  def create
    existing_match = Match.find_by(responder_id: current_user.id, initiator_id:params[:match][:responder_id])
    if existing_match
      flash[:match] = "You have been matched!"
      existing_match.update_attributes(accepted: 1)
    else
      Match.create(responder_id: params[:match][:responder_id],initiator_id: current_user.id)
    end
    redirect_to match_path(current_user.initiator_matches.where(accepted: 2).sample.responder_id)
  end

end


