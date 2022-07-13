FactoryBot.define do
  factory :asset do
    amount { 0 }
    average_price { 0 }
    total_invested { 0 }
    stock { create(:stock) }
    user { create(:user) }
    wallet { user.main_wallet }
  end
end
