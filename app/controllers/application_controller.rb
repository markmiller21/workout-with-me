class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :find_next_match
  before_action :require_login

  def current_user
  	if session[:user_id]
  		return User.find_by(id: session[:user_id])
  	else
  		return nil
  	end
  end

  def logged_in?
  	session[:user_id]
  end

  def find_next_match(current_user, potential_matches)
    for x in 0..potential_matches.length
      if Match.where(initiator_id: current_user.id, responder_id: potential_matches[x]) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: 1) != []
        next
      elsif Match.where(initiator_id: potential_matches[x], responder_id: current_user.id, accepted: -1) != []
        next
      else
        return potential_matches[x]
      end
    end
  end

  def get_potential_matches(current_user)
    potential_matches = []
    current_user.activities.each do |activity|
      activity.users.each do |user|
        if current_user != user
          potential_matches << user
        end
      end
    end
    return potential_matches
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "Please login to view"
      redirect_to login_path
    end
  end

end
