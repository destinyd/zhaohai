require 'spec_helper'

describe Activity do
  describe "#create sample activity" do
    activity = FactoryGirl.create(:activity)
    it "success"do
      activity.valid?.should be_true
    end

    it "#user will be nil"do
      activity.user.should be_nil
    end
  end

  it "#create {}" do
    activity = Activity.create
    activity.valid?.should be_false
    [:title,:lat,:lng].each do |attr|
      activity.should have(1).error_on(attr)
    end
  end
end
