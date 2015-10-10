class MatchesController < ApplicationController

	def show
    @match = Match.new
    @potential_match = User.find_by(id: params[:id])

    @possible_match = Match.find_by(id: params[:id])
    @possible_user = User.find(@possible_match.responder_id)
  end

  def create
    # existing_match = Match.find_by(responder_id: current_user.id, initiator_id:params[:match][:responder_id])
    # if existing_match
    #   flash[:match] = "You have been matched!"
    #   existing_match.update_attributes(accepted: 1)
    # else
    #   Match.create(responder_id: params[:match][:responder_id],initiator_id: current_user.id)
    # end
    # redirect_to match_path(current_user.initiator_matches.where(accepted: 2).sample.responder_id)

    # Gather all the users with a similar interest
    potential_matches = []
    current_user.activities.each do |activity|
      activity.users.each do |user|
        potential_matches << user
      end
    end
    for x in 0..potential_matches.length
      if Match.where(initiator_id: current_user.id, responder_id: potential_matches[x])
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: 1)
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: -1)
        next
      else
        print "Atleast we made it this far.  I am going to return #{potential_matches[x].name} who has #{potential_matches[x].activities}"
        return potential_matches[x]
      end 
    end
  end

end


