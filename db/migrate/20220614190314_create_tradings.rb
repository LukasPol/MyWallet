class CreateTradings < ActiveRecord::Migration[7.0]
  def change
    create_table :tradings do |t|
      t.date :date, null: false
      t.float :value, null: false
      t.integer :amount, null: false
      t.integer :kind, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
