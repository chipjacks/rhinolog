require 'spec_helper'

describe "User pages" do

	subject { page }

  describe "Sign up page" do

  	before { visit new_user_registration_path }

  	it { should have_selector('legend', text: 'Sign up') }
  	it { should have_selector('title', text: 'Sign up') }
  end

  describe "edit profile page" do

    let(:user) { FactoryGirl.create(:user) }

    before do 
      visit edit_user_registration_path
      sign_in user
    end

    it { should have_selector('legend', text: 'Edit') }
  end
end