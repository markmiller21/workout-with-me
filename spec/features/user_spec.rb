require 'rails_helper'

describe 'Logging in Process' do 
	let(:log_me_in){
		user = create(:user)
		visit login_path
		within("#login") do
			p user.inspect 
	    fill_in 'Email', :with => user.email
	    fill_in 'Password', :with => user.password
			p user.inspect 
	    click_button 'Login'
  	end
	}

	describe "When User enters valid information" do 
		it "they should be redirected to the activites page" do
			log_me_in
			expect(page).to have_content('Activities')
		end
	end

end