FactoryBot.define do
  factory :trading do
    date { Date.yesterday }
    value { 1.5 }
    total_value { 1.5 }
    amount { 1 }
    kind { 'buy' }
    user { create(:user) }
    wallet { user.main_wallet }
    stock { create(:stock) }
    asset { create(:asset, user: user, wallet: wallet, stock: stock) }
  end
end
