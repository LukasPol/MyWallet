class Stock < ApplicationRecord
  has_many :tradings, dependent: :restrict_with_error
  has_many :users, through: :tradings

  validates :code, presence: true
  validates :code, length: { in: 5..6 }

  scope :without_problem, -> { where(has_problem: false) }

  def to_s
    code
  end
end
