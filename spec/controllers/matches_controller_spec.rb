require "rails_helper"

describe MatchesController do

 let(:log_me_in) {
  @user = create(:user)
  session[:user_id] = @user.id
}

  describe "GET #show" do
    it "renders the #show view" do
      log_me_in
      @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
      get :show, id: @potential_user.id
      expect(response).to render_template :show
    end
  end

  describe "GET #index" do
    context "if user logged in" do
      before :each do
        @potential_user = create(:potential_user)
        log_me_in
      end

      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end

      it "populates an array of matches for a specific user" do
        match = Match.create(initiator_id: @user.id, responder_id: @potential_user.id,accepted: 1 )
        get :index
        expect(@user.initiator_matches).to eq([match])
      end
    end

    context "if user not logged in" do
      before :each do
        get :index
      end

      it "redirects to home page" do
        is_expected.to redirect_to root_path
      end

      it "should flash message" do
        expect(flash[:error]).to have_content("Please login to view")
      end
    end
  end

end


