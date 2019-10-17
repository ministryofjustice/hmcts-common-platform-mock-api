FactoryBot.define do
  factory :bail_status do
    code { 'Random string' }
    description { 'Random string' }
    custody_time_limit { nil }
  end
end
