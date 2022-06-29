class AddFieldsToStock < ActiveRecord::Migration[7.0]
  def change
    change_table :stocks, bulk: true do |t|
      t.string :company_name
      t.string :document
    end

    rename_column :stocks, :value, :price
  end
end
