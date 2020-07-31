require 'rails_helper'

RSpec.describe Person, type: :model do

  before(:each) do 
    @person = FactoryBot.create(:person)
  end

  it "has a valid factory" do
    expect(build(:person)).to be_valid
  end

  context "validations" do

    it "is valid with valid attributes" do
      expect(@person).to be_a(Person)
      expect(@person).to be_valid
    end

    describe "#reference" do
      it { expect(@person).to validate_presence_of(:reference) }
    end

    describe "#email" do
      it { expect(@person).to validate_presence_of(:email) }
    end

    describe "#firstname" do
      it { expect(@person).to validate_presence_of(:firstname) }
    end

    describe "#lastname" do
      it { expect(@person).to validate_presence_of(:lastname) }
    end

    describe "#home_phone_number" do
      it { expect(@person).to validate_presence_of(:home_phone_number) }
    end

    describe "#mobile_phone_number" do
      it { expect(@person).to validate_presence_of(:mobile_phone_number) }
    end

    describe "#address" do
      it { expect(@person).to validate_presence_of(:address) }
    end

  end


  context "public class methods" do

    describe "self.import" do
      it "should return the response in an array" do
        expect(Person.import(File.open("./app/assets/csvfiles/people.csv")).class).to eq(Array)
      end
    end

  end



end