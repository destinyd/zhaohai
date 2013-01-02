require 'spec_helper'

describe ActivityRequest do
  describe "#create {}" do
    activity_request = ActivityRequest.create
    [:user_id,:activity_id].each do |attr|
      it "#{attr} invalid" do
        activity_request.should have(1).error_on(attr)
      end
    end
  end

  describe "a richman hold a activity" do
    before(:each) do
      @richman = FactoryGirl.create(:richman)
      @activity_by_rich = FactoryGirl.create(:activity,user:@richman)
    end

    describe "a girl give a request to activity" do
      before(:each) do
        @girl = FactoryGirl.create(:girl)
        @activity_request = @girl.activity_requests.create(activity_id:@activity_by_rich.id,text: 'i`m beauty')
        @activity_by_rich.reload
      end

      it "admins will get Notification::InterestedActivitya notification" do
        @activity_by_rich.admins.each do |user|
          user.notifications.count.should == 1
          user.notifications.first.class.should == Notification::InterestedActivity
        end
      end

      describe "request#accept_by(richman)" do
        before(:each) do
          @activity_request.accept_by(@richman)
          @girl.reload
        end

        it "girl will get accept reply_status Notification::ActivityReply" do
          @girl.notifications.count.should == 1
          @girl.notifications.first.class.should == Notification::ActivityReply
        end
      end

    end
  end
end

