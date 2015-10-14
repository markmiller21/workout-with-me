require "rails_helper"

RSpec.describe UsersController do

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end


end

