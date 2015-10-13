require "rails_helper"

RSpec.feature "Ratings", :type => :feature do
  let(:potential_match) {
    create(:potential_user)
  }

  let(:potential_match2) {
    create(:potential_user2)
  }

  let(:log_me_in) {
    @user = create(:user)
    @user.activities.create(name: "Lifting")
    @user.locations.create(longitude: 131.123123,latitude: 123123.12312)
    potential_match
    potential_match.locations.create(longitude: 123.321,latitude: 98773.3215)
    potential_match2
    potential_match2.locations.create(longitude: 123.321,latitude: 98773.3215)
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Login'
  }

  describe "view user rating" do
    before :each do
      log_me_in
      potential_match.activities.create(name: "Lifting")
      match = Match.create(initiator_id: @user.id, responder_id: potential_match.id, accepted: 1)
    end

    scenario "shows average rating for potential match" do
      @first_rating = Rating.create(rater_id: @user.id, ratee_id: potential_match.id, rank: 5)
      potential_match2.activities.create(name: "Lifting")
      visit match_path(potential_match2)
      expect(page).to have_content("User Rating")
      expect(page).to have_content potential_match2.average_rating
    end

    scenario "shows average rating for match" do
      @first_rating = Rating.create(rater_id: @user.id, ratee_id: potential_match.id, rank: 5)
      visit matches_path
      expect(page).to have_content("User Rating")
      expect(page).to have_content potential_match.average_rating
    end

    scenario "shows message if no ratings exist" do
      visit matches_path
      expect(page).to have_content("This user has no ratings yet")
    end
  end
end