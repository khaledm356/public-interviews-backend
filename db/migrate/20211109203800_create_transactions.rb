class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :amount, default: 0
      t.references :giver, references: :accounts
      t.references :recevier, references: :accounts
      t.timestamps
    end
    add_foreign_key :transactions, :accounts, column: :giver_id
    add_foreign_key :transactions, :accounts, column: :recevier_id
  end
end
