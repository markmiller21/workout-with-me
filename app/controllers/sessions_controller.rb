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
	end
end
