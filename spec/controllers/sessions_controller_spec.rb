require "rails_helper"

describe SessionsController do
	describe "POST #create" do
		describe "When successful" do
			before(:each){
				@potential_user = create(:potential_user)
				@user = create(:user)
				@user.activities.create(name: "Tennis")
				@user.locations.create(longitude: 1231.12312, latitude: 12123.12312312)
			}
			let(:user_attr) {attributes_for(:user)}

			# it "redirects to a potential match page" do
			# 	@potential_user.activities.create(name: "Tennis")
			# 	post :create, session: { email: @user.email, password: @user.password }
			# 	expect(response).to redirect_to(initiate_match_path)
			# end

			it "sets a session" do
				post :create, session: { email: user_attr[:email], password: user_attr[:password] }
				expect(session).to have_key(:user_id)
			end

			it "sets session to the user_id" do
				post :create, session: { email: user_attr[:email], password: user_attr[:password] }
				expect(session[:user_id]).to eq(@user.id)
			end

			it "expects a message flash" do
				post :create, session: { email: user_attr[:email], password: user_attr[:password] }
				expect(flash[:message]).to have_content "You've succesfully logged in"
			end
		end

		describe "When unsuccesful" do
			before(:each){
				post :create, session: { email: 'nil', password: 'nil' }
			}

			it "redirects to login_path" do
				expect(response).to redirect_to(login_path)
			end

			it "doesn't set a session" do
				expect(session[:user_id]).to be_nil
			end

			it "expects an error flash" do
				expect(flash[:login_fail]).to have_content "Please input the correct username/password!"
			end
		end
	end

	describe "DELETE #destroy" do
		before(:each){
			user = create(:user)
			session[:user_id] = user.id
		}
		it "removes the user id from the session" do
			delete :destroy
			expect(session[:user_id]).to be_nil
		end

		it "redirects to the login page" do
			delete :destroy
			expect(response).to redirect_to(login_path)
		end

		it "expects a flash message" do
			delete :destroy
			expect(flash[:message]).to have_content "You've been succesfully logged out"
		end
	end
end




