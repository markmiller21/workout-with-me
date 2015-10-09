class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def create
  	user = User.new(user_params)
  	binding.pry
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :gender, :description, :age)
  end
end