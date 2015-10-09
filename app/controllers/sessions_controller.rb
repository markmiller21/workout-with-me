class SessionsController < ApplicationController
  def index
  end

  def new
  	#this is temporary for testing purposes
  	session[:user_id] = 1
  	redirect_to match_path(User.all.sample.id)
    #Redirection needs to change to different user based off algorthim
  end

  def create
	  auth_hash = request.env['omniauth.auth'].extra.raw_info
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      binding.pry
      user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
   
      render :text => "Hi #{user.name}! You've signed up."
    end
	end
end
