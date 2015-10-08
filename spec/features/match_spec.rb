require 'rails_helper'

describe 'possible match' do

  let(:log_me_in){
  user = create(:user)
  visit login_path
  click_link "Login Here"
}


  it 'page contains potential user on the page' do
    visit new_match_path
    potential_match = create(:user)
    expect(page).to have_content potential_match.name
  end


end

