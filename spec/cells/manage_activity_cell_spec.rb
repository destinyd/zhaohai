require 'spec_helper'

describe ManageActivityCell do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @activity = FactoryGirl.create(:activity,user:@user)
  end

  context "cell instance" do
    subject { cell(:manage_activity) }

    it { should respond_to(:true) }
    it { should respond_to(:false) }
  end

  context "cell rendering" do
    context "rendering true" do
      pending 'i don`t know how to test'
      #subject { render_cell(:manage_activity, :true,activity:@activity) }

      #it { should have_selector("input", :text => I18n.t('labels.edit')) }
    end

    context "rendering false" do
      pending 'i don`t know how to test'
      #subject { render_cell(:manage_activity, :false,activity:@activity) }

      #it { should have_selector("h1", :content => "ManageActivity#false") }
      #it { should have_selector("p", :content => "Find me in app/cells/manage_activity/false.html") }
    end
  end

end
