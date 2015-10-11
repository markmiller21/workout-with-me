require "rails_helper"

RSpec.feature "Ratings Page", :type => :feature do
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
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => potential_match.email
    fill_in 'Password', :with => potential_match.password
    click_button 'Login'
    click_link 'Logout'
  }
  let(:unmatched_user) {
    create(:unmatched_user)
    unmatched_user.activities.create(name: "Soccer")
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => unmatched_user.email
    fill_in 'Password', :with => unmatched_user.password
    click_button 'Login'
    click_link 'Logout'
  }

  before :each do
    log_me_in
  end
# is ratings going to be a link we can click somewhere?
  describe "ratings index page" do
    let(:rater_rating) { create(:rater_rating) }
    let(:rater_ratings) { [rater_rating, create(:rater_rating)] }
    let(:ratee_rating) { create(:ratee_rating) }
    let(:ratee_ratings) { [ratee_rating, create(:ratee_rating)] }

    it "shows all ratings user gave" do
      Match.create(initiator_id: @user.id, responder_id: potential_match.id, accepted: 1)

      visit ratings_path
      rater_ratings.each do |rater_rating|
        expect(page).to have_content rater_rating.rank
      end
    end

    it "shows all ratings user recieved" do
      visit ratings_path
      ratee_ratings.each do |ratee_rating|
        expect(page).to have_content ratee_rating.rank
      end
    end
  end
end