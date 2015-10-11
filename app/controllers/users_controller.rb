class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    ratee_ratings = Rating.where(ratee_id: @user.id).map do |ratee_rating|
      ratee_rating.rank
    end
    @average_rating = ratee_ratings.inject { |sum,rating| sum + rating }
  end

  def new
  	@user = User.new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		session[:user_id] = user.id
  		redirect_to activities_path
  	else
  		flash[:error] = "Invalid field, please try again"
  		redirect_to new_user_path
  	end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :gender, :description, :age)
  end
end