require "rails_helper"

RSpec.describe RatingsController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:matched_user) { create(:potential_user) }

  describe "POST #create" do
    before :each do
      log_me_in
      @user.activities.create(name: "Tennis")
      matched_user.activities.create(name: "Tennis")
      Match.create(initiator_id: @user.id, responder_id: matched_user.id, accepted: 1)
    end

    context "valid attributes" do
      it "should increase rating count" do
        expect {
          post :create, ratee_id: matched_user, rank: 5
        }.to change(Rating,:count).by(1)
      end

      it "should add rating to rated user" do
        expect {
          post :create, ratee_id: matched_user, rank: 5
        }.to change(@user.rater_ratings,:count).by(1)
      end
    end

    context "invalid attributes" do
      it "should not increase rating count" do
        expect {
          post :create, ratee_id: matched_user
        }.to_not change(Rating,:count)
      end
    end

  end


end