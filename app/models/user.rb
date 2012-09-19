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

  def phone_text
  	if @ohone_text
  		@phone_text
  	elsif self.phone
  		number_to_phone(self.phone, area_code: :true)
  	end
  end

  def save_phone_text
  	@phone_text.gsub!(/\D/, '') if @phone_text.is_a?(String)
    self[:phone] = @phone_text.to_i
  end

  def check_phone
  	if self.phone.to_s.length != 10
  		self.errors.add(:phone_text, "Please enter a 10 digit phone number")
  	end
  end

end
