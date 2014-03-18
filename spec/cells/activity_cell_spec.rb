require 'spec_helper'

describe ActivityCell do

  context "cell instance" do
    subject { cell(:activity) }

    it { should respond_to(:running) }
    it { should respond_to(:opening) }
    it { should respond_to(:plan) }
    it { should respond_to(:expired) }
    it { should respond_to(:closed) }
    it { should respond_to(:success) }
    it { should respond_to(:failure) }
  end

  context "cell rendering" do
    context "rendering running" do
      subject { render_cell(:activity, :running) }

      it { should have_selector("h1", :content => "Activity#running") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/running.html") }
    end

    context "rendering opening" do
      subject { render_cell(:activity, :opening) }

      it { should have_selector("h1", :content => "Activity#opening") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/opening.html") }
    end

    context "rendering plan" do
      subject { render_cell(:activity, :plan) }

      it { should have_selector("h1", :content => "Activity#plan") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/plan.html") }
    end

    context "rendering expired" do
      subject { render_cell(:activity, :expired) }

      it { should have_selector("h1", :content => "Activity#expired") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/expired.html") }
    end

    context "rendering closed" do
      subject { render_cell(:activity, :closed) }

      it { should have_selector("h1", :content => "Activity#closed") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/closed.html") }
    end

    context "rendering success" do
      subject { render_cell(:activity, :success) }

      it { should have_selector("h1", :content => "Activity#success") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/success.html") }
    end

    context "rendering failure" do
      subject { render_cell(:activity, :failure) }

      it { should have_selector("h1", :content => "Activity#failure") }
      it { should have_selector("p", :content => "Find me in app/cells/activity/failure.html") }
    end
  end

end
