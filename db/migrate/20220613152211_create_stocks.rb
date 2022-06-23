class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'

    create_table :stocks, id: :uuid do |t|
      t.string :name
      t.string :code
      t.float :value

      t.timestamps
    end
  end
end
