class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
  end

  def create
    last_match = Match.find_by(initiator_id: params[:match][:responder_id], responder_id: current_user.id)
    if last_match
      if params[:commit] == "LIKE"
        last_match.update_attributes(accepted: 1)
      else
        last_match.update_attributes(accepted: -1)
      end
    else
      last_match = Match.create(initiator_id: current_user.id, responder_id: params[:match][:responder_id])
    end
    potential_matches = []
    current_user.activities.each do |activity|
      activity.users.each do |user|
        if current_user != user
          potential_matches << user
        end
      end
    end

    next_match = find_next_match(current_user, potential_matches)
    redirect_to match_path(next_match)
  end
end
