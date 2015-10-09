require "rails_helper"

RSpec.describe ActivitiesController do
  let(:log_me_in) {
    user = User.create(name: "Jenny", email: "jenny@example.com", password_digest: "jenny", age: 25, gender: "Female", description: "I'm confused")
  }

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

  end

end