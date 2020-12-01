# frozen_string_literal: true

FactoryBot.define do
  factory :notified_plea do
    offence
    notifiedPleaDate { '2019-10-14' }
    notifiedPleaValue { 'NOTIFIED_GUILTY' }

    factory :realistic_notified_plea do
      association :offence, factory: :realistic_offence
      notifiedPleaDate { Date.today - Faker::Number.number(digits: 3).to_i.days }
      notifiedPleaValue { NotifiedPlea::VALUES.sample }
    end
  end
end
