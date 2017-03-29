require "rails_helper"

RSpec.describe ActivitiesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:activity_attr) { attributes_for(:activity) }
  let(:potential_match) { create(:potential_user) }

  before :each do
    log_me_in
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with invalid attributes" do
      it "should not redirect if activities not chosen" do
        post :create, user: {gender_preference: "Male"}
        expect(response).to_not redirect_to(match_path(potential_match))
      end

      it "sets flash error if activities not chosen" do
        post :create, user: {gender_preference: "Male"}
        expect(flash[:error]).to have_content("Must choose at least 1 activity")
      end

      it "should redirect to activities page again" do
        post :create, user: {gender_preference: "Male"}
        expect(response).to redirect_to(activities_path)
      end
    end

    context "with valid attributes" do
      it "returns 302 status" do
        post :create, name: ["Tennis", "Soccer"], gender_preference: "Male"
        expect(response.status).to eq(302)
      end

      it "should show potential matches page" do
        potential_match.activities.create(name: "Tennis")
        post :create, name: ["Tennis", "Soccer"], gender_preference: "Male"
        expect(response).to redirect_to initiate_match_path
      end

      it "should add activity to user activities" do
        potential_match.activities.create(name: "Tennis")
        expect {
          post :create, name: ["Tennis"], gender_preference: "Male"
        }.to change(@user.activities,:count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @activity = @user.activities.create(name: "Tennis")
    end

    it "deletes activity" do
      expect {
        delete :destroy, id: @activity
      }.to change(@user.activities,:count).by(-1)
    end

    it "should flash message after successful delete" do
      delete :destroy, id: @activity
      expect(flash[:message]).to have_content("Activity deleted")
    end
  end
end