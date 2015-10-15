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
      expect(response).to render_template :new
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      log_me_in
      get :show, id: potential_match
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    context "valid attributes" do
      it "creates new user" do
        expect {
          post :create, user: {name: user_attr[:name],email: user_attr[:email],password: user_attr[:password],age: user_attr[:age],gender: user_attr[:gender], long: 1.1,lat: 2.2}

        }.to change(User,:count).by(1)
      end

      it "redirects to activities path" do
        post :create, user: {name: user_attr[:name],email: user_attr[:email],password: user_attr[:password],age: user_attr[:age],gender: user_attr[:gender], long: 1.1,lat: 2.2}
        expect(response).to redirect_to activities_path
      end

      it "creates a new location for user" do
        expect {
          post :create, user: {name: user_attr[:name],email: user_attr[:email],password: user_attr[:password],age: user_attr[:age],gender: user_attr[:gender], long: 1.1,lat: 2.2}
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
        expect(response).to redirect_to new_user_path
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
        expect(response).to redirect_to new_user_path
      end
    end
  end

  describe "GET #edit" do
    it "renders the #edit view" do
      log_me_in
      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    before :each do
      log_me_in
    end

    context "valid attributes" do
      it "changes user's attributes" do
        patch :update, id: @user, user: { name: "Jenny" }
        @user.reload
        expect(@user.name).to eq("Jenny")
      end

      it "should redirect to user profile page" do
        patch :update, id: @user, user: { name: "Jenny" }
        expect(response).to redirect_to @user
      end

      it "should not create new user" do
        expect {
          patch :update, id: @user, user: user_attr
        }.to change(User,:count).by(0)
      end

      it "should flash success message" do
        patch :update, id: @user, user: { name: "Jenny" }
        expect(flash[:message]).to have_content("Updated successfully")
      end
    end

    context "invalid attributes" do
      it "does not change user's attributes" do
        patch :update, id: @user, user: { email: "jenny" }
        @user.reload
        expect(@user.email).to_not eq("jenny")
      end

      # it "redirects to edit page" do
      #   patch :update, id: @user, user: { email: "jenny" }
      #   response.should redirect_to edit_user_path(@user)
      # end
    end
  end

  describe "GET #edit_preferences" do
    it "renders the #edit_preferences view" do
      log_me_in
      get :edit_preferences, id: @user
      expect(response).to render_template :edit_preferences
    end
  end

  describe "PATCH #update_preferences" do
    before :each do
      log_me_in
    end

    context "valid attributes" do
      it "updates user's activities" do
        patch :update_preferences, id: @user, user: { gender_preference: "Female" }, name: ["Tennis", "Lifting"]
        @user.reload
        expect(@user.activities).to eq(Activity.where(name: ["Tennis", "Lifting"]))
      end

      it "updates user's gender preference" do
        patch :update_preferences, id: @user, user: { gender_preference: "Male" }, name: ["Tennis"]
        @user.reload
        expect(@user.gender_preference).to eq("Male")
      end

      it "should flash success message" do
        patch :update_preferences, id: @user, user: { gender_preference: "Male" }, name: ["Tennis"]
        expect(flash[:message]).to have_content("Preferences updated successfully")
      end
    end

    context "invalid attributes" do
      it "does not change activities without gender preference chosen" do
        patch :update_preferences, id: @user, name: ["Tennis"]
        @user.reload
        expect(@user.activities).to_not eq(Activity.find_by(name: "Tennis"))
      end

      it "does not change gender preference without activities chosen" do
        patch :update_preferences, id: @user, user: { gender_preference: "Male" }
        @user.reload
        expect(@user.gender_preference).to_not eq("Male")
      end

      it "should flash error message" do
        patch :update_preferences, id: @user, user: { gender_preference: "Male" }
        expect(flash[:error]).to have_content("Must choose at least 1 activity/preference")
      end
    end
  end
end

