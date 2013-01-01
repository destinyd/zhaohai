require 'spec_helper'

describe NotificationCell do

  context "cell instance" do
    subject { cell(:notification) }

    it { should respond_to(:interested_activity) }
  end

  context "cell rendering" do
    context "rendering interested_activity" do
      pending 'notest'
      #subject { render_cell(:notification, :interested_activity) }

      #it { should have_selector("h1", :content => "Notification#interested_activity") }
      #it { should have_selector("p", :content => "Find me in app/cells/notification/interested_activity.html") }
    end
  end

end
