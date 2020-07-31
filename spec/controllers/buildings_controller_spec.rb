require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do

  before :each do
    @building = FactoryBot.create(:building)
  end

  describe "GET #index" do
    it "assigns @building" do
      # on va sur index
      get :index

      # @users doit être une array qui contient user
      expect(assigns(:buildings)).to eq([@building])
    end

    it "renders the index template" do
      # va sur index
      get :index

      # on doit rediriger vers index
      expect(response).to render_template("index")
    end
  end

  describe "POST #import" do
    it "redirect to the building index" do
     # test à écrire
    end
  end


end