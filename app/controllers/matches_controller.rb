class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
  end

  def create
    match = Match.new(responder_id: params[:match][:responder_id],initiator_id: 2)
    if Match.where(responder_id: 2, initiator_id:params[:match][:responder_id])
      flash[:match] = "You have been matched!"
      match.update(accepted: 1)
    else
      match = Match.create(responder_id: params[:match][:responder_id],initiator_id: 2)
    end
          redirect_to match_path(User.all.sample.id)
  end


end

#1. Instaniate a new  match
#2. Find a potential match
#3. If