FactoryBot.define do
  factory :proceed do
    date { Date.yesterday }
    value { 1.5 }
    amount { 1 }
    kind { 'dividends' }
    user { create(:user) }
    wallet { user.main_wallet }
    stock { create(:stock) }
  end
end
