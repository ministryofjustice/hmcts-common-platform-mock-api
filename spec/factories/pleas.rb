# frozen_string_literal: true

FactoryBot.define do
  factory :plea do
    originatingHearingId { SecureRandom.uuid }
    offenceId { SecureRandom.uuid }
    pleaDate { '2019-10-14 14:59:41' }
    pleaValue { 'GUILTY' }

    factory :realistic_plea do
      originatingHearingId { SecureRandom.uuid }
      offenceId { SecureRandom.uuid }
      pleaDate { Faker::Date.backward }
      pleaValue { Plea::VALUES.sample }
    end
  end
end
