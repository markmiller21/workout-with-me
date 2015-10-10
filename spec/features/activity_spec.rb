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

  scenario "should show all activities" do
    visit activities_path
    expect(page).to have_content("Select Your Activities")
  end

  scenario "should show images associated with activities" do
    visit activities_path
    expect(page).to have_selector("img[src$='#{}']")
  end

  # scenario "should show link to add an activity" do
  #   visit activities_path
  #   expect(page).to have_link("Submit new activity")
  # end

end