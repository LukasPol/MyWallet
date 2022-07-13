class AddFieldsToTrading < ActiveRecord::Migration[7.0]
  def change
    change_table :tradings, bulk: true do |t|
      t.float :total_value
      t.references :asset, null: false, foreign_key: true, type: :uuid
    end
  end
end
