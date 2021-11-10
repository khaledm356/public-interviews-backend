# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  balance         :float            default(0.0)
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  phone_number    :string
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_accounts_on_email         (email)
#  index_accounts_on_phone_number  (phone_number)
#  index_accounts_on_status        (status)
#
class Account < ApplicationRecord
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :balance, :numericality => { :greater_than_or_equal_to => 0}
  has_secure_password

  def add_balance(amount)
    self.balance =  self.balance.to_f + amount
    save
  end

  def substract_balance(amount)
    self.balance =  self.balance.to_f - amount
    save
  end
  
  enum status: {
    unverified: -1,
    pending: 0,
    verified: 1
  }, _suffix: true
end
