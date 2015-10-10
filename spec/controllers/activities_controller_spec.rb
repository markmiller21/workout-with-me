require "rails_helper"
# change User.all.sample to filtered users

RSpec.describe ActivitiesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:activity_attr) { attributes_for(:activity) }
  let(:create_activity) { @user.activities.create(name: activity_attr[:name], image: activity_attr[:image])}

  before :each do
    log_me_in
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    context "with invalid attributes" do
      it "should not redirect if activities not chosen" do
        post :create
        expect(response).to_not redirect_to(match_path(User.all.sample.id))
      end

      #why is this working?
      it "sets flash error if activities not chosen" do
        post :create
        expect(flash[:error]).to have_content("Must choose at least 1 activity")
      end
    end

    # context "with valid attributes" do
    #   it "should redirect to potential matches page" do
    #     post :create, activity: {name: "tennis"}
    #     expect(response).to redirect_to(match_path(User.all.sample.id))
    #   end
    # end

  end

end