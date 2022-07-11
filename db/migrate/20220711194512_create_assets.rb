class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets, id: :uuid do |t|
      t.integer :amount, default: 0
      t.float :average_price, default: 0
      t.references :stock, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :wallet, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
