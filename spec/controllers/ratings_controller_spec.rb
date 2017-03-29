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

    context "valid rating given" do
      it "should increase rating count" do
        expect {
          post :create, rating: { ratee_id: matched_user, rank: 5 }
        }.to change(Rating,:count).by(1)
      end

      it "should add rater rating to rating user" do
        expect {
          post :create, rating: { ratee_id: matched_user, rank: 5 }
        }.to change(@user.rater_ratings,:count).by(1)
      end

      it "should add ratee rating to rated user" do
        expect {
          post :create, rating: { ratee_id: matched_user, rank: 5 }
        }.to change(matched_user.ratee_ratings,:count).by(1)
      end
    end

    context "no rating given" do
      it "should not increase rating count" do
        expect {
          post :create, rating: { ratee_id: matched_user }
        }.to_not change(Rating,:count)
      end

      it "should flash error" do
        post :create, rating: { ratee_id: matched_user }
        expect(flash[:error]).to have_content("Cannot submit empty rating")
      end
    end
  end
end