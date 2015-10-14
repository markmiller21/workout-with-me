require "rails_helper"

RSpec.describe UsersController do
  let(:log_me_in) {
    @user = create(:user)
    @user.locations.create(longitude: 123.321,latitude: 98773.3215)
    session[:user_id] = @user.id
  }
  let(:potential_match) { @potential_match = create(:potential_user) }

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      log_me_in
      get :show, id: potential_match
      response.should render_template :show
    end

    it "assigns the requested user to @user" do
      log_me_in
      potential_match
      get :show, id: potential_match
      assigns(:potential_match).should eq(@potential_match)
    end
  end


end

