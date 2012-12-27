require 'spec_helper'

describe "story 1" do
  describe "a richman hold a activity" do
    before(:each) do
      @richman = FactoryGirl.create(:richman)
      @activity_by_rich = FactoryGirl.create(:activity,user:@richman)
    end

    describe "a girl interesting in activity" do
      before(:each) do
        @girl = FactoryGirl.create(:girl)
        @activity_by_rich.interested @girl
      end

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

        it "girl activities include activity" do
          @girl.in_activities.should include(@activity_by_rich)
        end
      end

    end
  end
end
