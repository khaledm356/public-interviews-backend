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
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { is_expected.to validate_presence_of(:giver) }
  it { is_expected.to validate_presence_of(:recevier) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to belong_to(:giver) }
  it { is_expected.to belong_to(:recevier) }

  it "has a valid factory" do
    giver = FactoryBot.create(:account, balance: 20)
    transaction = FactoryBot.create(:transaction,giver: giver, amount: 10)
    giver.reload
    expect(transaction).to be_valid
    expect(giver.balance).to eq(10)
    expect(transaction.recevier.balance).to eq(10)
  end

  it "should raise error if the kudo amount bigger than the giver availble balance" do
    transaction = FactoryBot.build(:transaction, amount: 1000)
    expect(transaction.save).to be false
  end
end
