FactoryBot.define do
  factory :seeding_hearing do
    seeding_hearing_id { "9c1da4c6-244e-4d5b-af32-28833673910d" }
    jurisdiction_type { "CROWN" }
    sitting_day { "11-03-2021" }

    factory :realistic_seeding_hearing do
      seeding_hearing_id { SecureRandom.uuid }
      jurisdiction_type { SeedingHearing::JURISDICTION_TYPES.sample }
      sitting_day { Faker::Date.forward(days: 3) }
    end
  end
end
