class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wallets
  has_many :tradings

  validates :email, :password, :password_confirmation, presence: true

  after_create do
    Wallet.create(name: 'Principal', user_id: id)
  end
end
