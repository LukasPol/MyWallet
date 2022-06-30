class Proceed < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  belongs_to :wallet

  enum kind: { dividends: 0, jcp: 1 }

  validates :value, :amount, :date, :kind, :user, :stock, :wallet, presence: true

  validate do
    errors.add(:date, I18n.t(:after_today, scope: 'activerecord.errors.models.proceed.attributes.date')) if date && date > Time.zone.today
  end
end
