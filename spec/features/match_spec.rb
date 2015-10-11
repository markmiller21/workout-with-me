require 'rails_helper'

describe 'possible match page' do

  let(:log_me_in) {
    @user = create(:user)
    @user.activities.create(name:"Lifting")
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Login'
  }

  let(:dummy_user){
    @dummy = create(:user)
    @dummy.activities.create(name: "Lifting")
    visit root_path
    click_link "Login Here"
    fill_in 'Email', :with => @dummy.email
    fill_in 'Password', :with => @dummy.password
    click_button 'Login'
    click_link 'Logout'
  }

  let(:potential_user) {
    matched_user = create(:potential_user)
  }
  let(:unmatched_user) {
    unmatched_user = create(:unmatched_user)
  }
  before(:each) do
    dummy_user
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
      Match.create(initiator_id:@user.id, responder_id: @dummy.id)
      click_button "LIKE"
      click_link "My matches"
    end

    it 'list a match on the page' do
      Match.create(initiator_id:@user.id, responder_id: @dummy.id, accepted: 2)
      click_link "My matches"
      expect(page). to have_content @dummy.name
    end
  end



end

