class Trading < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  belongs_to :stock
  belongs_to :asset

  enum kind: { buy: 0, hold: 1 }

  validates :value, :amount, :date, :kind, :user, :stock, :wallet, :total_value, presence: true
  validates :value, :amount, :total_value, numericality: { greater_than: 0 }

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'activerecord.errors.models.trading.attributes.date')) if date && date > Time.zone.today
  end

  before_validation do
    asset = Asset.find_or_create_by(stock: stock, user: user, wallet: wallet)
    self.asset = asset
  end
end
