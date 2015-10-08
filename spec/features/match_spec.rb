require 'rails_helper'

describe 'possible match' do

  let(:log_me_in){
    @logged_in_user = User.create(name:"raj",password_digest:"raj",age:22,gender:"Male",description:"yolo",email:"raj@raj.com")
  # user = create(:user)
  visit root_path
  click_link "Login Here"
}


it 'page contains potential user on the page' do
  log_me_in
  @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
  visit match_path(@potential_user)
  expect(page).to have_content @potential_user.name
end

it 'page contains a see more button ' do
  log_me_in
  expect(page).to have_content "See more"
end

it 'page redirects to correct page when clicking See more link' do
  log_me_in
  @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
  click_link "See more"
  expect(page).to have_content "This is the jenny profile page"
end

end

