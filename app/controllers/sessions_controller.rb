class SessionsController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(username: session_params[:username])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      flash[:message] = "You've succesfully logged in"
      redirect_to activities_path
    else
      flash[:error] = "Invalid field, try logging in again"
      redirect_to login_path
    end
	end

  private
  
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
