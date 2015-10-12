class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index,:new,:create]

  def new
    @user = User.new
  end

  def create
    # binding.pry
    user = User.find_by(email: session_params[:email])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      user.locations.first.update_attributes(latitude:params[:session][:lat],longitude: params[:session][:long])
      flash[:message] = "You've succesfully logged in"
      potential_matches = get_potential_matches(current_user)
      next_match = find_next_match(current_user, potential_matches)
      if next_match == nil
        render file: "error"
      else
        redirect_to match_path(next_match)
      end
    else
      flash[:error] = "Invalid field, try logging in again"
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
    params.require(:session).permit(:email, :password)
  end
end
