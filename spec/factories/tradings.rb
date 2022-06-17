FactoryBot.define do
  factory :trading do
    date { Date.yesterday }
    value { 1.5 }
    amount { 1 }
    kind { 'buy' }
    user { create(:user) }
    wallet { user.wallets.first }
    stock { create(:stock) }
  end
end
