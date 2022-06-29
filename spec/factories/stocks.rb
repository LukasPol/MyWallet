FactoryBot.define do
  factory :stock do
    name { 'Petrobras' }
    code { 'PETR4' }
    price { 1.5 }
    company_name { 'Petrobras S\A' }
    document { '12312312312' }
  end
end
