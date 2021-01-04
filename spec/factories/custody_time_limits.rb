# frozen_string_literal: true

FactoryBot.define do
  factory :custody_time_limit do
    timeLimit { "2019-10-16 14:33:00" }
    daysSpent { 10 }

    factory :realistic_custody_time_limit do
      timeLimit { DateTime.now + Faker::Types.rb_integer }
      daysSpent { Faker::Types.rb_integer }
    end
  end
end
