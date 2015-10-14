require 'rails_helper'
RSpec.feature "Matches", :type => :feature do
  let(:log_me_in) {
    @user = create(:user)
    @user.locations.create(longitude: 131.123123,latitude: 123123.12312)
    @user.activities.create(name:"Lifting")
    visit root_path
   first(:link,"Login Here").click
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Login'
    @user.locations.first.update_attributes(longitude: 131.123123,latitude: 123123.12312)
  }


  let(:unmatched_user) { unmatched_user = create(:unmatched_user) }
  # let(:potential_users) {[@potential_match, @match]}

  before(:each) do
    @potential_match = create(:potential_user)
    @matched_user = create(:potential_user2)
    @potential_match.activities.create(name: "Lifting")
    @potential_match.locations.create(longitude: 123.321,latitude: 98773.3215)
    @matched_user.activities.create(name: "Lifting")
    @matched_user.locations.create(longitude: 123.321,latitude: 98773.3215)
    log_me_in
  end
  describe 'possible match page' do
    it 'contains potential user on the page' do
      visit match_path(@potential_match)
      expect(page).to have_content @potential_match.name
    end

    it 'redirects to the next user if liked clicked' do
      visit match_path(@potential_match)
      click_button "LIKE"
      expect(page).to_not have_content @potential_match.name
    end

    # it "should flash message if matched" do
    #   matched_user.initiator_matches.create(responder_id: @user.id)
    #   visit match_path(matched_user)
    #   click_button "LIKE"
    #   expect(page).to have_content "You've been matched!"
    # end
  end

  describe 'user matches page' do
    it 'shows the matches for a current user' do
      Match.create(initiator_id: @matched_user.id, responder_id: @user.id, accepted: 1)
      click_link "Matches"
      expect(page).to have_content "Here are your matches " + @user.name
    end

    it 'list a match on the page' do
      Match.create(initiator_id:@user.id, responder_id: @matched_user.id, accepted: 1)
      click_link "Matches"
      expect(page).to have_content @matched_user.name
    end
  end
end
