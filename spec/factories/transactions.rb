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
FactoryBot.define do
  factory :transaction do
    amount { 1.5 }
    giver_id    { create(:account).id }
    recevier_id    { create(:account).id }
  end
end
