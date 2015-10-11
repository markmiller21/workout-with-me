class RatingsController < ApplicationController

  def create
    rater_rating = Rating.create(rater_id: current_user.id, ratee_id: params[:ratee_id], rank: params[:rank])
    redirect_to #match/:id/chat
  end

end
