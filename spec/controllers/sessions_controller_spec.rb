require "rails_helper"

describe SessionsController do
	describe "POST #create" do
		describe "When successful" do
			before(:each){
				@user = create(:user)
			}
			let(:user) {attributes_for(:user)}

			it "redirects to the activities page" do
				post :create, session: { email: user[:email], password: user[:password] }
				expect(response).to redirect_to(activities_path)
			end

			it "sets a sessoin" do 
				post :create, session: { email: user[:email], password: user[:password] }
				expect(session).to have_key(:user_id)
			end

			it "sets session to the user_id" do 
				post :create, session: { email: user[:email], password: user[:password] }
				expect(session[:user_id]).to eq(@user.id)
			end
			
			it "expects a message flash" do
				post :create, session: { email: user[:email], password: user[:password] }
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
      	expect(flash[:error]).to have_content "Invalid field, try logging in again"
      end
		end

		describe "DELETE #destroy" do
			before(:each){
				user = create(:user)
				session[:user_id] = user.id
			}
			it "redirects to the login page" do 
				delete :destroy
				expect(session[:user_id]).to be_nil
			end
		end
	end
end




