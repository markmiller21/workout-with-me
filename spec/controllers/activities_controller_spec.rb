require "rails_helper"

RSpec.describe ActivitiesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:activity_attr) { attributes_for(:activity) }
  let(:create_activity) { create(:activity)}
  let(:potential_match) { create(:potential_user) }


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
        expect(response).to_not redirect_to(match_path(potential_match))
      end

      it "sets flash error if activities not chosen" do
        post :create
        expect(flash[:error]).to have_content("Must choose at least 1 activity")
      end

      it "should redirect to activities page again" do
        post :create
        expect(response).to redirect_to(activities_path)
      end
    end

    context "with valid attributes" do
      before :each do
        subject { post :create, activity: "Tennis" }
        # @user.activities << Activity.create(name: "Tennis")
        # potential_match.activities << Activity.create(name: "Tennis")
      end

      it "returns 200 ok status" do
        expect(response).to have_http_status(200)
      end

      it "should redirect to potential matches page" do
        expect(subject).to redirect_to(match_path(potential_match))
      end

      # it "increases user activities amount of activities selected" do
      #   expect {
      #     post :create,
      #   }
      # end
    end
  end
end