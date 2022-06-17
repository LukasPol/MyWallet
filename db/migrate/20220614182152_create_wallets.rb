class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.index [:name, :user_id], unique: true

      t.timestamps
    end
  end
end