class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index,:new,:create]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      user.locations.first.update_attributes(latitude: session_params[:lat],longitude: session_params[:long])
      flash[:message] = "You've succesfully logged in"
      potential_matches = user.get_potential_matches
      next_match = user.find_next_match(potential_matches)
      if next_match == nil
        render file: "error"
      else
        redirect_to match_path(next_match)
      end
    else
      flash[:login_fail] = "Please input the correct username/password!"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "You've been succesfully logged out"
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password,:lat,:long)
  end
end
