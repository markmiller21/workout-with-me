require 'rails_helper'

describe 'Logging in Process' do

	before(:each) do
		potential_user = create(:potential_user)
	end



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
		it "they should be redirected to the matches page" do
			log_me_in
			expect(page).to have_content('Potential match')
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
	let(:user_attr){attributes_for(:user)}
	it "Valid user" do
		visit new_user_path
		fill_in 'Name', :with => user_attr[:name]
		fill_in 'Email', :with => user_attr[:email]
		fill_in 'Password', :with => user_attr[:password]
		fill_in 'Gender', :with => user_attr[:gender]
		fill_in 'Description', :with => user_attr[:description]
		fill_in 'Age', :with => user_attr[:age]
		click_button("Register")
		expect(page).to have_content('Activities')
	end

	it "With Invalid Name field" do
		visit new_user_path
		fill_in 'Name', :with => nil
		fill_in 'Email', :with => user_attr[:email]
		fill_in 'Password', :with => user_attr[:password]
		fill_in 'Gender', :with => user_attr[:gender]
		fill_in 'Description', :with => user_attr[:description]
		fill_in 'Age', :with => user_attr[:age]
		click_button("Register")
		expect(page).to have_content('Register')
	end

	# describe 'User index page' do

	# 	it 'on the correct user' do
	# 		user = create(:user)



end
