require 'rails_helper'

describe 'Logging in Process' do 
	let(:log_me_in){
		user = create(:user)
		visit_login_path
		within("#login") do
	    fill_in 'Username', :with => user.username
	    fill_in 'Password', :with => user.password
	    click_button 'Login'
  	end
	}

end