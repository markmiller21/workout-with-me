require "rails_helper"

RSpec.describe RatingsController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:matched_user) { create(:potential_user) }

  describe "POST #create" do
    context "valid attributes" do
      it "should add rating to matched users's ratings" do
        @user.activities.create(name: "Tennis")
        matched_user.activities.create(name: "Tennis")
        Match.create(initiator_id: @user.id, responder_id: matched_user.id, accepted: 1)
        expect {
          post :create,

        }.to change(Rating,:count).by(1)
      end
    end
  end


end