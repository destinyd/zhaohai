require 'spec_helper'

describe City do
  describe "#create {}" do
    city = City.create
    [:name].each do |attr|
      it "#{attr} should be invalid" do
        city.should have(1).error_on(:name)
      end
    end
  end

  it "#create" do
    city = FactoryGirl.create(:city)
    city.should be_valid
  end
end
