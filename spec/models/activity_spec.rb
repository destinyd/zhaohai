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

  describe "#create {}" do
    activity = Activity.create
    [:title,:lat,:lng].each do |attr|
      it "#{attr} invalid" do
        activity.should have(1).error_on(attr)
      end
    end
  end

  describe "richman hold activity" do
    before(:each) do
      @richman = FactoryGirl.create(:richman)
      @activity_by_rich = FactoryGirl.create(:activity,user:@richman)
    end

    it "#is_open?" do
      @activity_by_rich.is_open?.should be_true
    end

    it "#user_name == richman" do
      @activity_by_rich.user_name.should == 'richman'
    end

    it "#admin == richman" do
      @activity_by_rich.admin.should == @richman
    end

    it "#finish" do
      @activity_by_rich.finish(@richman).should_not be_nil
    end

    it "#is_open? ==  false after finish" do
      @activity_by_rich.finish(@richman)
      @activity_by_rich.is_open?.should be_false
    end

  end
end
