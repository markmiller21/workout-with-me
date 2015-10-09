class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
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