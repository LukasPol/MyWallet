require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end

  it '.my_Stocks' do
    user = create(:user)
    stock = create(:stock, code: 'OIBR4')
    create_list(:trading, 3, user: user, stock: stock)

    expect(user.my_stocks).to eq([['OIBR4', stock.id]])
  end
end
