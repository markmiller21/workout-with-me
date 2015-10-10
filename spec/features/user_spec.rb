require 'rails_helper'

describe 'Logging in Process' do 
	let(:log_me_in){
		user = create(:user)
		visit login_path
		within("#login") do
	    fill_in 'Email', :with => user.email
	    fill_in 'Password', :with => user.password
	    click_button 'Login'
  	end
	}

	describe "When User enters valid information" do 
		it "they should be redirected to the activites page" do
			log_me_in
			expect(page).to have_content('Activities')
		end
	end

	describe "When User enters INvalid information" do 
		it "they should be redirected to the login page" do
			visit login_path
			fill_in 'Email', :with => nil
	    fill_in 'Password', :with => nil
	    click_button 'Login'
			expect(page).to have_content('Login')
		end
	end
end

describe 'Sign up process' do 

end
