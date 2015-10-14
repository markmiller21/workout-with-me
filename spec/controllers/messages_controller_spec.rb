require "rails_helper"

RSpec.describe MessagesController do
  let(:log_me_in) {
    @user = create(:user)
    @user.locations.create(longitude: 123.321,latitude: 98773.3215)
    session[:user_id] = @user.id
  }
  let(:user_attr) { attributes_for(:user) }
  let(:potential_match) { @potential_match = create(:potential_user) }

  let(:matched_user) {
    @matched_user = create(:potential_user2)
  }
  before :each do
    @shared_activity = create(:activity)
    potential_match
    matched_user
    @matched_user.activities << @shared_activity
    log_me_in
    @user.activities << @shared_activity
    @match = @matched_user.initiator_matches.create(responder_id: @user.id, accepted: 1)
  end

  describe "GET #index" do
    it "renders the chat page" do
      get :index, match_id: @match
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
  end
end