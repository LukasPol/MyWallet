FactoryBot.define do
  factory :asset do
    amount { 10 }
    average_price { 10.5 }
    stock { create(:stock) }
    user { create(:user) }
    wallet { user.main_wallet }
  end
end
