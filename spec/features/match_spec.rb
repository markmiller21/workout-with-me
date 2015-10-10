require 'rails_helper'

describe 'possible match' do

  let(:log_me_in){
    @logged_in_user = User.create(name:"raj",password_digest:"raj",age:22,gender:"Male",description:"yolo",email:"raj@raj.com")
  # user = create(:user)
  visit root_path
  click_link "Login Here"
}

  before(:each) do
    log_me_in
  end

it 'page contains potential user on the page' do

  @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
  visit match_path(@potential_user)
  expect(page).to have_content @potential_user.name
end

it 'page contains a see more button ' do

  expect(page).to have_content "See more"
end

it 'page redirects to correct page when clicking See more link' do

  click_link "See more"
  expect(page).to have_content "Profile page"
  #Can't test going to a specific user yet, due to algorithm not being created
end

it 'page redirects to the next user if liked clicked' do

  @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
  visit match_path(@potential_user)
  click_link "LIKE"
  expect(page).to_not have_content @potential_user.name
end

end

