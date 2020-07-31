require 'rails_helper'

RSpec.describe PeopleController, type: :controller do

  before :each do
    @person = FactoryBot.create(:person)
  end

  describe "GET #index" do
    it "assigns @people" do
      # on va sur index
      get :index

      # @users doit être une array qui contient user
      expect(assigns(:people)).to eq([@person])
    end

    it "renders the index template" do
      # va sur index
      get :index

      # on doit rediriger vers index
      expect(response).to render_template("index")
    end
  end

  describe "POST #import" do
    it "redirect to the people index" do
      # test à écrire
    end
  end


end