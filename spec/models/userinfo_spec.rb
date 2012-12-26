require 'spec_helper'

describe Userinfo do
  describe "#create {}" do
    userinfo = Userinfo.create
    [:gender,:birth].each do |attr|
      it "#{attr} invalid" do
        userinfo.should have(1).error_on(attr)
      end
    end
  end

  describe "user with userinfo" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @userinfo = @user.userinfo
    end

    it "#valid" do
      @userinfo.valid?.should be_true
    end

    it "#realname" do
      @userinfo.realname.should == 'someone'
    end
  end

  describe "male" do
    before(:each) do
      @user = FactoryGirl.create(:user,:male)
      @userinfo = @user.userinfo
    end

    it "#human_gender" do
      @userinfo.human_gender.should == I18n.t('gender.false')
    end
  end

  describe "female" do
    before(:each) do
      @user = FactoryGirl.create(:user,:female)
      @userinfo = @user.userinfo
    end

    it "#human_gender" do
      @userinfo.human_gender.should == I18n.t('gender.true')
    end
  end
end
