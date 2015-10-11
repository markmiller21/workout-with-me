require "rails_helper"

RSpec.feature "Ratings Page", :type => :feature do
  let(:log_me_in) {
    @user = create(:user)
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
end