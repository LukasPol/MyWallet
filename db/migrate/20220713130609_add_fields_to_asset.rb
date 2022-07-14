class AddFieldsToAsset < ActiveRecord::Migration[7.0]
  def change
    change_table :assets, bulk: true do |t|
      t.float :total_invested, default: 0
      t.index [:stock_id, :user_id, :wallet_id], unique: true
    end
  end
end
