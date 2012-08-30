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

class Run < ActiveRecord::Base
  attr_accessible :date, :distance, :feel, :pace, :mins
  belongs_to :user

  validates :user_id, presence: true
  validates :date, presence: true
  validates :distance, presence: true
  validates :pace, presence: true
  validates :mins, presence: true

  default_scope order: 'runs.date DESC'
end
