require "rails_helper"

RSpec.feature "User Ratings", :type => :feature do
  let(:log_me_in) {
    @user = create(:user)
    @user.activities.create(name: "Lifting")
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Login'
  }

  let(:potential_match) {
    create(:potential_user)
    potential_match.activities.create(name: "Lifting")
  }

  let(:potential_match2) {
    create(:potential_user2)
    potential_match2.activities.create(name: "Lifting")
  }

  describe "view user rating" do
    before :each do
      log_me_in
      match = Match.create(initiator_id: @user.id, responder_id: potential_match.id, accepted: 1)
      first_rating = Rating.create(rater_id: @user.id, ratee_id: potential_match.id, rank: 5)
    end

    scenario "shows average rating for match" do
      visit matches_path
      expect(page).to have_content("Average Rating")
    end
  end
end