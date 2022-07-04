class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wallets, dependent: :delete_all
  has_many :tradings, dependent: :delete_all
  has_many :proceeds, dependent: :delete_all
  has_many :stocks, through: :tradings

  validates :email, :password, :password_confirmation, presence: true

  after_create do
    Wallet.create(name: 'Principal', user_id: id)
  end

  def main_wallet
    wallets.first
  end

  def my_stocks
    stocks.without_problem.map do |s|
      [s.code, s.id]
    end.uniq
  end
end
