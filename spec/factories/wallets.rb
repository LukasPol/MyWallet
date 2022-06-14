FactoryBot.define do
  factory :wallet do
    name { 'Principal' }
    user { create(:user) }
  end
end
