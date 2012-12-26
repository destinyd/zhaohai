require 'spec_helper'

describe Comment do
  describe "#create {}" do
    it "text invalid" do
      @comment = Comment.create
      @comment.should have(1).error_on(:text)
    end
  end

  describe "#create" do
    it "invalid" do
      @comment = FactoryGirl.create(:comment)
      @comment.should be_valid
    end
  end

  describe "girl comment richman" do
    before(:each) do
      @girl = FactoryGirl.create(:girl)
      @richman = FactoryGirl.create(:richman)
      @comment = FactoryGirl.create(:comment,user_id:@girl.id,commentable: @richman)
    end

    it "@girl.comments include comment" do
      @girl.comments.should include(@comment)
    end

    it "@richman.commenteds include comment" do
      @richman.commenteds.should include(@comment)
    end
  end
end
