# == Schema Information
#
# Table name: transactions
#
#  id          :bigint           not null, primary key
#  amount      :float            default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  giver_id    :bigint
#  recevier_id :bigint
#
# Indexes
#
#  index_transactions_on_giver_id     (giver_id)
#  index_transactions_on_recevier_id  (recevier_id)
#
# Foreign Keys
#
#  fk_rails_...  (giver_id => accounts.id)
#  fk_rails_...  (recevier_id => accounts.id)
#
class Transaction < ApplicationRecord
    validates :giver, presence: true
    validates :amount, presence: true
    validates :recevier, presence: true
    validates :amount, :numericality => { :greater_than_or_equal_to => 1}
    belongs_to :giver, class_name: "Account", foreign_key: "giver_id"
    belongs_to :recevier, class_name: "Account", foreign_key: "recevier_id"
    validate :giver_not_receiver
    validate :giver_have_enough_balance

    before_save :update_balance

    def update_balance
       giver.substract_balance(amount)
       recevier.add_balance(amount)
    end

    def giver_have_enough_balance
        return if amount.blank? || giver_id.blank?
        errors.add(:giver, 'giver dont have enough balance') if amount > giver.balance
    end
    

    def giver_not_receiver
        errors.add(:giver, 'giver cannot be the recevier') if giver ==  recevier      
    end
    
end
