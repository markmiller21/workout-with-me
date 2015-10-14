class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :find_next_match
  before_action :require_login
  # add_flash_types :blank_username

  # flash { success: "It worked!", error: "It failed." }
  def current_user
    if logged_in?
  		return User.find(session[:user_id])
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
    potential_matches = Hash.new
    current_user.activities.each do |activity|
      if current_user.gender_preference == "No preference"
        potential_users = activity.users
      else
        potential_users = activity.users.where(gender: current_user.gender_preference)
      end
        potential_users.each do |user|
          if current_user != user
            if potential_matches[user]
              potential_matches[user] += 1
            else
              potential_matches[user] = 1
            end
          end
        end
      end
    return potential_matches.sort {|a1,a2| a2[1]<=>a1[1]}
  end

  def calculate_distance(loc1, loc2)
    rad_per_deg = Math::PI/180
    rkm = 6371
    rm = rkm * 1000

    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    (rm * c) * (0.00062137)
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "Please login to view"
      redirect_to root_path
    end
  end

end
