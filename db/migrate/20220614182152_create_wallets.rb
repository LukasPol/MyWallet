class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.index [:name, :user_id], unique: true

      t.timestamps
    end
  end
end
