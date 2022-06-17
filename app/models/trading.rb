class Trading < ApplicationRecord
  belongs_to :user
  belongs_to :wallet
  belongs_to :stock

  enum kind: { buy: 0, hold: 1 }

  validates :value, :amount, :date, :kind, :user, :stock, :wallet, presence: true
  validates :value, numericality: { greater_than: 0 }

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'activerecord.errors.models.trading.attributes.date')) if date && date > Time.zone.today
  end
end
