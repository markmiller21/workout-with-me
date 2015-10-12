class RatingsController < ApplicationController

  def create
    rater_rating = current_user.rater_ratings.build(rating_attributes)
    if rater_rating.save
      flash[:message] = "Your rating has been submitted"
      redirect_to match_messages_path
    else
      flash[:error] = "Cannot submit empty rating"
    end
  end

  private

    def rating_attributes
      params.require(:rating).permit(:rank, :ratee_id)
    end

end
