require "rails_helper"

RSpec.feature "Messages", :type => :feature do
  let(:matched_user) { @matched_user = create(:potential_user) }
  let(:log_me_in) {
    @user = create(:user)
    @user.activities.create(name: "Lifting")
    @user.locations.create(longitude: 131.123123,latitude: 123123.12312)
    visit root_path
   first(:link,"Login Here").click
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Login'
  }

  describe "messages index page" do
    before :each do
      matched_user.activities.create(name: "Lifting")
      log_me_in
      Match.create(initiator_id: @matched_user.id, responder_id: @user.id, accepted: 1)
      visit matches_path
      click_link @matched_user.name
    end

    context "both users matched" do

      scenario "should have matched user rating" do
        expect(page).to have_content("User Rating")
        expect(page).to have_content @matched_user.average_rating
      end

      scenario "should have linked to user profile page" do
        expect(page).to have_content "Description"
      end
    end
  end
end