class SessionsController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      flash[:message] = "You've succesfully logged in"
      redirect_to activities_path
    else
      flash[:error] = "Invalid field, try logging in again"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "You have been succesfully logged out"
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
