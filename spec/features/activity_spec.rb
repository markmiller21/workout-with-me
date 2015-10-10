require "rails_helper"

RSpec.feature "Activities Page", :type => :feature do
  let(:log_me_in) {
    user = create(:user)
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Login'
  }

  let(:create_activity) { create(:activity) }
  let(:activity_attr) { attributes_for(:activity) }

  before :each do
    log_me_in
  end
  describe "create activities" do
    scenario "should show all activities" do
      visit activities_path
      expect(page).to have_content("Select Your Activities")
    end

    scenario "should have button to create activities" do
      visit activities_path
      expect(page).to have_button("Create Activity")
    end

    scenario "should show images associated with activities" do
      visit activities_path
      expect(page).to have_selector("img[src$='#{}']")
    end

    # scenario "show error message if activity not chosen" do
    #   visit activities_path
    #   click_button 'Create Activity'
    #   expect(page).to have_content("Must choose at least 1 activity")
    # end
  end
end