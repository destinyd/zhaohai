require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  describe "following system" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
      @user1.follow! @user2
      @user1.follow! @user3
      @user2.follow! @user3
      @users = [@user1,@user2,@user3]
    end

    3.times do |index|
      it "@user#{index + 1}.following should #{3-index-1}" do
        @users[index].following.count.should == (3-index -1)
      end
      it "@user#{index+1}.followers should #{index}" do
        @users[index].followers.count.should == (index)
      end
    end
  end

  describe "following notification system" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user1.follow! @user2
    end

    it "@user2 will get follower notification" do
      @user2.notifications.first.class.should == Notification::Follower
    end
  end

  describe "friend system" do
    before(:each) do
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user1.follow! @user2
      @user2.follow! @user1
    end

    it "@user1.friend include @user2 after follow each other" do
      @user1.friend.should include(@user2)
    end
    it "@user2.friend include @user1 after follow each other" do
      @user2.friend.should include(@user1)
    end
  end

  describe :create_phone_test do
    let(:user) do
      User.create_phone_test
    end

    it "name should start with i18n phone user" do
      user.name.should start_with(I18n.t('random.phone'))
    end

    it 'encrypted_password blank' do
      user.encrypted_password.should be_blank
    end
  end


end
