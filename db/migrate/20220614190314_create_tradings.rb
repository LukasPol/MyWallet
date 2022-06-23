class CreateTradings < ActiveRecord::Migration[7.0]
  def change
    create_table :tradings, id: :uuid do |t|
      t.date :date, null: false
      t.float :value, null: false
      t.integer :amount, null: false
      t.integer :kind, default: 0, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :stock, null: false, foreign_key: true, type: :uuid
      t.references :wallet, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
