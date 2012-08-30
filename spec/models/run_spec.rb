# == Schema Information
#
# Table name: runs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  date       :date
#  mins       :integer
#  distance   :decimal(5, 2)
#  pace       :integer
#  feel       :integer          default(2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Run do
  let(:user) { FactoryGirl.create(:user) }
  before { @run = user.runs.build(date: '2012-08-29', mins: '56', distance: '8', pace: '420') }

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

  describe "with mins being blank" do
    before { @run.mins = '' }
    it { should_not be_valid }
  end

  describe "with distance being blank" do
    before { @run.distance = '' }
    it { should_not be_valid }
  end

  describe "with pace being blank" do
    before { @run.pace = '' }
    it { should_not be_valid }
  end
end
