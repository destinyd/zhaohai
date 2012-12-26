require 'spec_helper'

describe "story 1" do
  describe "a richman hold a activity" do
    before(:each) do
      @richman = FactoryGirl.create(:richman)
      @activity_by_rich = FactoryGirl.create(:activity)
      @activity_by_rich.holder = @richman
      @activity_by_rich.users << @richman
    end

    describe @activity_by_rich do

      it "#is_open?" do
        @activity_by_rich.is_open?.should be_true
      end

      it "#user_name == richman" do
        @activity_by_rich.user_name.should == 'richman'
      end

      it "#admin == richman" do
        @activity_by_rich.admin.should == @richman
      end
    end

    describe "a girl want to join activity" do
      before(:each) do
        @girl = FactoryGirl.create(:user)
        @activity_by_rich.interested @girl
      end

      describe @activity_by_rich do
        it "girl in activity interested_users" do
          @activity_by_rich.interested_users.should include(@girl)
        end

        it "#accept will be true" do
          @activity_by_rich.accept(@richman, @girl).should be_true
        end

        describe "girl in activity users after admin accept" do
          before(:each) do
            @activity_by_rich.accept(@richman, @girl)
          end
          it "#interested_users not include girl" do
            @activity_by_rich.interested_users.should_not include(@girl)
          end
          it "#users include girl" do
            @activity_by_rich.users.should include(@girl)
          end
        end

        it "#is_open?" do
          @activity_by_rich.is_open?.should be_true
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
  end
end
