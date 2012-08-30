# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do

	before { @user = User.new(email: "user@example.com",
		password: "foobar", password_confirmation: "foobar") }

	subject { @user }

	it { should respond_to(:email) }
  it { should respond_to(:runs) }

	it { should be_valid }

	describe "run associations" do

    before { @user.save }
    let!(:older_run) do 
      FactoryGirl.create(:run, user: @user, date: 3.day.ago)
    end
    let!(:newer_run) do
      FactoryGirl.create(:run, user: @user, date: 1.day.ago)
    end

    it "should have the right runs in the right order" do
      @user.runs.should == [newer_run, older_run]
    end

    it "should destroy associated runs" do
      runs = @user.runs
      @user.destroy
      runs.each do |run|
        Run.find_by_id(run.id).should be_nil
      end
    end
  end
end
