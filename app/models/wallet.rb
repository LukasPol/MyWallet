class Wallet < ApplicationRecord
  belongs_to :user

  validates :name, :user, presence: true
  validates :name, uniqueness: {
    scope: :user_id,
    message: I18n.t(:taken, scope: 'activerecord.errors.models.wallet.attributes.name'),
    case_sensitive: false
  }
end
