require "rails_helper"

describe MatchesController do

  describe "GET #show" do

    it "renders the #show view" do
      get :show, id: create(:user)
      response.should render_template :show
    end
  end


end