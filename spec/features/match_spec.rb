require 'rails_helper'

describe 'possible match page' do

  let(:log_me_in) {
    user = create(:user)
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Login'
  }

  let(:dummy_user){
    user = create(:user)
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'Login'
    find(:css, "#_name[value='Lifting']").set(true)
    click_link "Create Activity"
    click_button 'Logout'
  }

  let(:potential_user) {
    matched_user = create(:potential_user)
  }
  let(:unmatched_user) {
    unmatched_user = create(:unmatched_user)
  }
  before(:each) do
    log_me_in
  end

  it 'page contains potential user on the page' do
    visit match_path(potential_user)
    expect(page).to have_content potential_user.name
  end

  it 'page contains a see more button ' do
    visit match_path(potential_user)
    expect(page).to have_content "See more"
  end

  it 'page redirects to correct page when clicking See more link' do
    visit match_path(potential_user)
    click_link "See more"
    expect(page).to have_content "Profile page"
  end

  # it 'page redirects to the next user if liked clicked' do
  #   visit match_path(potential_user)
  #   click_button "LIKE"
  #   expect(page).to_not have_content potential_user.name
  # end

  describe 'user matches page' do
    it 'shows on the matches for a current user' do
      log_me_in
      # visit activities_path
      find(:css, "#name_[value='Lifting']").set(true)
      click_link "Create Activity"
    end
  end



end

