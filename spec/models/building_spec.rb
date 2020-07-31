require 'rails_helper'

RSpec.describe Building, type: :model do

  before(:each) do 
    @building = FactoryBot.create(:building)
  end

  it "has a valid factory" do
    expect(build(:building)).to be_valid
  end

  context "validations" do

    it "is valid with valid attributes" do
      expect(@building).to be_a(Building)
      expect(@building).to be_valid
    end

    describe "#reference" do
      it { expect(@building).to validate_presence_of(:reference) }
    end

    describe "#address" do
      it { expect(@building).to validate_presence_of(:address) }
    end

    describe "#zip_code" do
      it { expect(@building).to validate_presence_of(:zip_code) }
    end

    describe "#city" do
      it { expect(@building).to validate_presence_of(:city) }
    end

    describe "#country" do
      it { expect(@building).to validate_presence_of(:country) }
    end

    describe "#manager_name" do
      it { expect(@building).to validate_presence_of(:manager_name) }
    end

  end

  context "associations" do

    describe "buiding_backups" do
      it { expect(@building).to have_many(:building_backups) }
    end

  end

  context "public class methods" do

    describe "self.import" do
      it "should return the response in an array" do
        expect(Building.import(File.open("./app/assets/csvfiles/buildings.csv")).class).to eq(Array)
      end
    end

  end

end