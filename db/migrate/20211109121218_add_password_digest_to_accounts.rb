class AddPasswordDigestToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :password_digest, :string
  end
end
