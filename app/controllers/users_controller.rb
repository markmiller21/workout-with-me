class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end

  def create
  	user = User.new(user_params)
  end

end