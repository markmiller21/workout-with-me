require "rails_helper"

RSpec.feature "Activity Page", :type => :feature do
  let(:log_me_in) {
    user = User.create(name: "Jenny", email: "jenny@example.com", password_digest: "jenny", age: 25, gender: "Female", description: "I'm confused")
    visit root_path
    click_link "Login Here"
  }

  before :each do
    log_me_in
  end

  scenario "User can view activities" do
    visit activities_path
    expect(page).to have_content("Select Your Activities")
  end

end