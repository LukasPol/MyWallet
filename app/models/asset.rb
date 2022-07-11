class Asset < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  belongs_to :wallet

  validates :stock, :user, :wallet, :amount, :average_price, presence: true

  validates :average_price, :amount, numericality: { greater_than_or_equal_to: 0 }
end
