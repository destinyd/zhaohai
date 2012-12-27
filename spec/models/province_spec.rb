require 'spec_helper'

describe Province do
  describe "#create {}" do
    province = Province.create
    [:name].each do |attr|
      it "#{attr} should be invalid" do
        province.should have(1).error_on(:name)
      end
    end
  end

  it "#create" do
    province = FactoryGirl.create(:province)
    province.should be_valid
  end

  describe "#create with cities_attributes" do
    before(:each) do
      @province1 = Province.create({name: "1",cities_attributes: [{name: "1"},{name: "2"},{name: "3"},{name: "4"},{name: "5"},{name: "6"},{name: "7"},{name: "8"},{name: "9"},{name: "10"},{name: "1"}]})
    end

    it "province1 should be valid" do
      @province1.should be_valid
    end

    it "province1 have 11 cities" do
      @province1.cities.count.should be(11)
    end

    describe "same province" do
      @province2 = Province.create({name: "1",cities_attributes: [{name: "1"},{name: "2"},{name: "3"},{name: "4"},{name: "5"},{name: "6"},{name: "7"},{name: "8"},{name: "9"},{name: "10"},{name: "1"}]})

      it "province2 should be nil" do
        @province2.should be_nil
      end
    end
  end
end

