require "rails_helper"

RSpec.feature "Messages", :type => :feature do
  let(:matched_user) { create(:potential_user) }
  let(:log_me_in) {
    @user = create(:user)
    @user.activities.create(name: "Lifting")
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.Password
    click_button 'Login'
  }

end