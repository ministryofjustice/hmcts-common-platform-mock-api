FactoryBot.define do
  factory :custody_time_limit do
    timeLimit { "2019-10-16 14:33:00" }
    daysSpent { 10 }
  end
end
