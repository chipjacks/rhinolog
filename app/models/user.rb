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
#  phone                  :integer
#

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
#  phone                  :integer
#
include ActionView::Helpers::NumberHelper

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :phone_text, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  attr_writer :phone_text

  has_many :runs, dependent: :destroy

	before_validation :save_phone_text
  validate :check_phone
  validates_uniqueness_of :phone, allow_nil: true, :message => "There is already an account with that phone number."
  after_validation :add_phone_text_errors

  def phone_text
  	if @ohone_text
  		@phone_text
  	elsif self.phone != 0
  		number_to_phone(self.phone, area_code: :true)
  	end
  end

  def save_phone_text
  	if @phone_text.is_a?(String)
      @phone_text.gsub!(/\D/, '')
      self[:phone] = @phone_text.to_i
    end
  end

  def check_phone
  	if !self.phone_text.blank? && self.phone.to_s.length != 10
  		self.errors.add(:phone_text, "Please enter a 10 digit phone number")
  	end
    if self.phone == 0
      self.phone = nil
    end
  end

  def add_phone_text_errors
    if self.errors.get(:phone)
      self.errors.add(:phone_text, "There is already an account with that phone number.")
    end
  end

end
