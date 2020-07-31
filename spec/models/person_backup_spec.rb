require 'rails_helper'

RSpec.describe PersonBackup, type: :model do
  before(:each) do 
    @backup = FactoryBot.create(:person_backup)
  end

  it "has a valid factory" do
    expect(build(:person_backup)).to be_valid
  end

  context "associations" do

    describe "buiding" do
      it { expect(@backup).to belong_to(:person) }
    end

  end
end
