class AddTotalInvestedToAsset < ActiveRecord::Migration[7.0]
  def change
    add_column :assets, :total_invested, :float, default: 0
  end
end
