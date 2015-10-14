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

    context "missing fields" do
      it "should flash error message" do
        post :create, user: { email: "jenny@example.com", password: "jenny", gender: "Female", age: 25 }
        expect(flash[:errors]).to have_content("can't be blank")
      end

      it "empty name does not create new user" do
        expect {
          post :create, user: { email: "jenny@example.com", password: "jenny", gender: "Female", age: 25 }
        }.to change(User,:count).by(0)
      end

      it "empty email does not create new user" do
        expect {
          post :create, user: { name: "Jenny", password: "jenny", gender: "Female", age: 25 }
        }.to change(User,:count).by(0)
      end

      it "empty password does not create new user" do
        expect {
          post :create, user: { name: "Jenny", email: "jenny@example.com", gender: "Female", age: 25 }
        }.to change(User,:count).by(0)
      end

      it "no age does not create new user" do
        expect {
          post :create, user: { name: "Jenny", email: "jenny@example.com", password: "jenny", gender: "Female", description: "I lift" }
        }.to change(User,:count).by(0)
      end

      it "no gender chosen does not create new user" do
        expect {
          post :create, user: { name: "Jenny", email: "jenny@example.com", password: "jenny", description: "I lift" }
        }.to change(User,:count).by(0)
      end

      it "redirects to sign up page" do
        post :create, user: { email: "jenny@example.com", password: "jenny", gender: "Female", age: 25 }
        response.should redirect_to new_user_path
      end
    end

    context "invalid email" do
      it "should not create new user" do
        expect {
          post :create, user: { name: "Jenny", email: "jenny", password: "jenny", age: 25, gender: "Female", description: "I lift" }
        }.to change(User,:count).by(0)
      end

      it "should flash error message" do
        post :create, user: { name: "Jenny", email: "jenny", password: "jenny", age: 25, gender: "Female", description: "I lift" }
        expect(flash[:errors]).to have_content("Invalid email address")
      end

      it "redirects to sign up page" do
        post :create, user: { name: "Jenny", email: "jenny", password: "jenny", gender: "Female", age: 25 }
        response.should redirect_to new_user_path
      end
    end
  end

end

