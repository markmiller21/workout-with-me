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
  end

  describe "GET #index" do
    context "both users liked" do
      before :each do
        @match = @matched_user.initiator_matches.create(responder_id: @user.id, accepted: 1)
      end

      it "renders the chat page" do
        get :index, match_id: @match
        expect(response).to render_template :index
      end

      it "displays all the messages received and sent" do
        get :index, match_id: @match
        expect(@match.messages).to eq(@user.receiver_messages + @matched_user.sender_messages)
      end
    end

    # context "only one user liked" do
    #   before :each do
    #     @one_sided_match = @matched_user.initiator_matches.create(responder_id: @user.id, accepted: 0)
    #   end

      # it "does not render chat page" do
      #   get :index, match_id: @one_sided_match
      #   expect(response).to_not render_template :index
      # end
    # end
  end

  describe "POST #create" do
    before :each do
      @match = @matched_user.initiator_matches.create(responder_id: @user.id, accepted: 1)
    end

    xit "increases message count by 1" do
      expect {
        post :create, match_id: @match,  message: { match_id: @match.id, sender_id: @user.id, receiver_id: @matched_user.id, content: "Hey!" }
      }.to change(Message,:count).by(1)
    end

    xit "increases sender messages count by 1" do
      expect {
        post :create, match_id: @match,  message: { match_id: @match.id, sender_id: @user.id, receiver_id: @matched_user.id, content: "Hey!" }
      }.to change(@user.sender_messages,:count).by(1)
    end

    xit "increases receiver messages count by 1" do
      expect {
        post :create, match_id: @match,  message: { match_id: @match.id, sender_id: @user.id, receiver_id: @matched_user.id, content: "Hey!" }
      }.to change(@matched_user.receiver_messages,:count).by(1)
    end
  end
end