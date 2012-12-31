require 'spec_helper'

describe JoinActivityCell do

  context "cell instance" do
    subject { cell(:join_activity) }

    it { should respond_to(:true) }
    it { should respond_to(:false) }
  end

  context "cell rendering" do
    context "rendering true" do
      pending 'i don`t know how to test'
      #subject { render_cell(:join_activity, :true) }

      #it { should have_selector("h1", :content => "JoinActivity#true") }
      #it { should have_selector("p", :content => "Find me in app/cells/join_activity/true.html") }
    end

    context "rendering false" do
      pending 'i don`t know how to test'
      #subject { render_cell(:join_activity, :false) }

      #it { should have_selector("h1", :content => "JoinActivity#false") }
      #it { should have_selector("p", :content => "Find me in app/cells/join_activity/false.html") }
    end
  end

end
