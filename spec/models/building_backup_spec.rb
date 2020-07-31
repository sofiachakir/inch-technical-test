require 'rails_helper'

RSpec.describe BuildingBackup, type: :model do
  before(:each) do 
    @backup = FactoryBot.create(:building_backup)
  end

  it "has a valid factory" do
    expect(build(:building_backup)).to be_valid
  end

  context "associations" do

    describe "buiding" do
      it { expect(@backup).to belong_to(:building) }
    end

  end
end
