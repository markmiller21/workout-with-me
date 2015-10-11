class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user.try(:authenticate, session_params[:password])
      session[:user_id] = user.id
      flash[:message] = "You've succesfully logged in"


      random_user = User.where.not(id: current_user.id ).sample
      if Match.find_by(responder_id: random_user.id, initiator_id: current_user.id) || Match.find_by(responder_id: current_user.id, initiator_id: random_user.id)
        render file: "error"
      else
        redirect_to match_path(random_user)
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
