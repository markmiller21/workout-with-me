class RatingsController < ApplicationController

  def create
    rater_rating = current_user.rater_ratings.build(rating_attributes)
    if rater_rating.already_exists?
      flash[:error] = "You've already rated this user"
    else
      if rater_rating.save
        flash[:message] = "Your rating has been submitted"
      else
        flash[:error] = "Cannot submit empty rating"
      end
    end
    redirect_to match_messages_path(rater_rating.match)
  end

  private

    def rating_attributes
      params.require(:rating).permit(:rank, :ratee_id)
    end

end
