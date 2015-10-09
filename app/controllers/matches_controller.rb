class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
  end

  def create
    match = Match.build(responder_id: params[:match][:responder_id],initiator_id: current_user)
    if Match.where(responder_id: current_user, initiator_id:params[:match][:responder_id])
      flash[:match] = "You have been matched!"
      match.update(accepted: 1)
    else
      match = Match.create(responder_id: params[:match][:responder_id],initiator_id: current_user)
    end
          redirect match_show(User.all.sample.id)
  end