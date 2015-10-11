require "rails_helper"

describe MatchesController do

  describe "GET #show" do

    let(:log_me_in) {
      @user = create(:user)
      session[:user_id] = @user.id
    }




    it "renders the #show view" do
     @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
     get :show, id: @potential_user.id
     expect(response).to render_template :show
   end


   describe "GET #index" do
    it "renders the :index view" do
      log_me_in
      get :index
      expect(response).to render_template :index

    end
  end

end


end