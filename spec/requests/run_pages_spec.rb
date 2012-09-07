require 'spec_helper'

describe "Run pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:otheruser) {FactoryGirl.create(:user) }
  before { sign_in user }

  describe "run creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a run" do
        expect { click_button "Deposit" }.should_not change(Run, :count)
      end

      describe "error messages" do
        before { click_button "Deposit" }
        it { should have_content('problems') } 
      end
    end

    describe "with valid information" do
      before do
        fill_in 'run_time_text', with: '1h 20m'
        fill_in 'run_pace_text', with: '8m'
        fill_in 'run_distance', with: '10'
      end

      it "should create a run" do
        expect { click_button "Deposit" }.should change(user.runs, :count).by(1)
      end
    end
  end

  describe "run deletion" do
    before do
      FactoryGirl.create(:run, user: user)
    end

    describe "as correct user" do
      before { visit root_path }

      it "should delete a run" do
        expect { click_link "delete" }.to change(user.runs, :count).by(-1)
      end
    end
  end

  # describe "micropost destruction" do
  #   before { FactoryGirl.create(:micropost, user: user) }

  #   describe "as correct user" do
  #     before { visit root_path }

  #     it "should delete a micropost" do
  #       expect { click_link "delete" }.should change(Micropost, :count).by(-1)
  #     end
  #   end

  #   describe "as wrong user" do
  #     before do
  #       FactoryGirl.create(:micropost, user: otheruser)
  #       visit user_path(otheruser)
  #     end

  #     it "should not have delete links" do
  #       page.should_not have_link('delete')
  #     end
  #   end
  # end
end