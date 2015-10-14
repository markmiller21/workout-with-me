class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
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
