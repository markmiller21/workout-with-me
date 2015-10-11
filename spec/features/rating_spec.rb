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
    potential_match
    potential_match2
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
      @first_rating = Rating.create(rater_id: @user.id, ratee_id: potential_match.id, rank: 5)
    end

    scenario "shows average rating for potential match" do
      potential_match2.activities.create(name: "Lifting")
      visit match_path(potential_match2)
      expect(page).to have_content("Average Rating")
      expect(page).to have_content Rating.average_rating(potential_match2)
    end

    # scenario "shows average rating for match" do
    #   visit matches_path
    #   expect(page).to have_content("Average Rating")
    #   expect(page).to have_content Rating.average_rating(potential_match)
    # end
  end
end