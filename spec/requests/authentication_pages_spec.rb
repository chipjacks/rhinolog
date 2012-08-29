require 'spec_helper'

describe "Authentication pages" do

	subject { page }

  describe "Sign in page" do

  	before { visit new_user_session_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_selector('title', text: 'Sign in') }

  end

  describe "sign in" do

		let(:user) { FactoryGirl.create(:user) }

  	before do 
  		visit new_user_session_path
  	end

  	describe "with invalid information" do

  		describe "should not sign in a user" do
  			before do
  			  fill_in "Email", with: "joo@example.com"
  			  fill_in "Password", with: "joobar"
  			  click_button "Sign in"
  			end

  			it { should have_selector('div.alert.alert-alert', text: 'Invalid') }

  			describe "after visiting another page" do
  				before { visit root_path }
  				it { should_not have_content('Signed in') }
  			end
  		end
  	end

  	describe "with valid information" do
  		before do
 			  fill_in "Email", with: user.email
  		  fill_in "Password", with: user.password
  		  click_button "Sign in"
  		end
  		
  		describe "should sign in a user" do
  			it { should have_selector('div.alert.alert-notice', text: 'success') }
  		end

  		describe "after visiting another page" do
  				before { visit root_path }
  				it { should have_content('Signed in') }
  				it { should have_link('Edit profile') }
  			end
  	end
  	
  end
end
