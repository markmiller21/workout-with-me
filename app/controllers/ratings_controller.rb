class RatingsController < ApplicationController

  def create
    rater_rating = current_user.rater_ratings.build(ratee_id: params[:ratee_id], rank: params[:rank])
    if rater_rating.save
      redirect_to #match/:id/chat
    else
      flash[:error] = "Cannot submit empty rating"
    end
  end

end
