require "rails_helper"

RSpec.describe UsersController do
  let(:log_me_in) {
    @user = create(:user)
    @user.locations.create(longitude: 123.321,latitude: 98773.3215)
    session[:user_id] = @user.id
  }
  let(:user_attr) { attributes_for(:user) }
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
  end

  describe "POST #create" do
    context "valid attributes" do
      it "creates new user" do
        expect {
          post :create, user: user_attr
        }.to change(User,:count).by(1)
      end

      it "redirects to activities path" do
        post :create, user: user_attr
        response.should redirect_to activities_path
      end

      it "creates a new location for user" do
        expect {
          post :create, user: user_attr
        }.to change(Location,:count).by(1)
      end
    end
  end

end

