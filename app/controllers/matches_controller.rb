class MatchesController < ApplicationController

  def index
    @initiator_matches = current_user.initiator_matches.where(accepted: 1)
    @responder_matches = current_user.responder_matches.where(accepted: 1)

  end

  def initiate_match
    potential_matches = current_user.get_potential_matches
    next_match = current_user.find_next_match(potential_matches)
    if next_match == nil
      render file: "error"
    else
      redirect_to match_path(next_match)
    end
  end

  def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])
    @average_rating = @potential_match.average_rating
    @distance_in_miles = calculate_distance([@potential_match.locations.first.latitude,@potential_match.locations.first.longitude],[current_user.locations.first.latitude,current_user.locations.first.longitude]).to_i
  end

  def create
    last_match = Match.find_by(initiator_id: params[:match][:responder_id], responder_id: current_user.id)
    if last_match
      if params[:commit] == "LIKE"
        last_match.update_attributes(accepted: 1)
        flash[:message] = "You've been matched!"
      else
        last_match.update_attributes(accepted: -1)
      end
    else
      if params[:commit] == "LIKE"
        Match.create(initiator_id: current_user.id, responder_id: params[:match][:responder_id], accepted: 0)
      else
        Match.create(initiator_id: current_user.id, responder_id: params[:match][:responder_id], accepted: -1)
      end
    end

    potential_matches = current_user.get_potential_matches
    next_match = current_user.find_next_match(potential_matches)
    if next_match == nil
      render file: "error"
    else
      flash[:alert] = "You have a match!!!"
      redirect_to match_path(next_match)
    end
  end
end
