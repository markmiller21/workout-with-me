class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    @location = Location.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @average_rating = @user.average_rating
  end

  def create
  	user = User.new(user_params)
  	if user.save && user.valid?
      session[:user_id] = user.id
      if params[:user][:long] != ""
        user.locations.create(longitude:params[:user][:long], latitude:params[:user][:lat])
      else
        user.locations.create(longitude:40.7484, latitude:73.9857)
      end
      redirect_to activities_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.save
      current_user.update(user_params)
      flash[:message] = "Updated successfully"
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def edit_preferences
    @user = current_user
    render :edit_preferences
  end

  def update_preferences
    chosen_activities = params[:name]
    if chosen_activities && params[:user]
      current_user.add_activities(chosen_activities)
      current_user.update_attributes(gender_preference: params[:user][:gender_preference])
      flash[:message] = "Preferences updated successfully"
    else
      flash[:error] = "Must choose at least 1 activity/preference"
    end
    redirect_to edit_preferences_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :gender, :description, :age, :avatar)
  end


end