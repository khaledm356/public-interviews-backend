class AddBalanceToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :balance, :float, default: 0.0
  end
end
