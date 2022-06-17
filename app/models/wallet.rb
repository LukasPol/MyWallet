class Wallet < ApplicationRecord
  belongs_to :user
  has_many :tradings, dependent: :destroy

  validates :name, :user, presence: true

  validates :name, uniqueness: {
    scope: :user_id,
    message: I18n.t(:taken, scope: 'activerecord.errors.models.wallet.attributes.name'),
    case_sensitive: false
  }
end
