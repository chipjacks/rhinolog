# == Schema Information
#
# Table name: runs
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  date         :date
#  time_in_secs :integer
#  distance     :decimal(5, 2)
#  pace_in_secs :integer
#  feel         :integer          default(2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  comment      :text
#

require 'spec_helper'

describe Run do
  let(:user) { FactoryGirl.create(:user) }
  before { @run = user.runs.build(date: '2012-08-29', time_text: '1h 20m', 
          distance: '12', pace_text: '7m 30s') }

  subject { @run }

  it { should respond_to(:date) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  its(:user) { should == user }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Run.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @run.user_id = nil }
    it { should_not be_valid }
  end

  describe "with time and pace being blank" do
    before { @invalid_run = user.runs.build(date: '2012-08-29', time_text: '', 
          distance: '12', pace_text: '') }

    it { @invalid_run.should_not be_valid }
  end

  describe "with distance and pace being blank" do
    before { @invalid_run = user.runs.build(date: '2012-08-29', time_text: '1h 20m', 
          distance: '', pace_text: '') }

    it { @invalid_run.should_not be_valid }
  end

  describe "with distance and time being blank" do
    before { @invalid_run = user.runs.build(date: '2012-08-29', time_text: '', 
          distance: '', pace_text: '7m 30s') }

    it { @invalid_run.should_not be_valid }
  end
end
