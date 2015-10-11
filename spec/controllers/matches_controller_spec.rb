require "rails_helper"

describe MatchesController do

 let(:log_me_in) {
      @user = create(:user)
      session[:user_id] = @user.id
    }

  describe "GET #show" do
    it "renders the #show view" do
     @potential_user = User.create(name:"jenny",password_digest:"jenny",age:25,gender:"female",description:"just think about it",email:"jenny@jenny.com")
     get :show, id: @potential_user.id
     expect(response).to render_template :show
   end

end

   describe "GET #index" do
    it "renders the :index view" do
      log_me_in
      get :index
      expect(response).to render_template :index
    end

  it "populates an array of matches for a specific user" do
    @potential_user = create(:potential_user)
    log_me_in
    match = Match.create(initiator_id: @user.id, responder_id: @potential_user.id,accepted: 1 )
    get :index
    expect(@user.initiator_matches).to eq([match])
  end

  end

end


