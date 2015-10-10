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
    for x in 0..potential_matches.length
      if Match.where(initiator_id: current_user.id, responder_id: potential_matches[x]) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: 1) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: -1) != []
        next
      else
        redirect_to match_path(potential_matches[x])
        break
      end
    end
  end
end
