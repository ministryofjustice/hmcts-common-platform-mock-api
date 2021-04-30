FactoryBot.define do
  factory :court_order_offence do
    offence { association :offence }
    prosecution_case_id { "3c5e33ba-51d5-413c-8145-6f6e7ea9ecac" }
    prosecution_case_identifier { association :prosecution_case_identifier }

    factory :realistic_court_order_offence do
      association :offence, factory: :realistic_offence
      prosecution_case_id { SecureRandom.uuid }
      association :prosecution_case_identifier, factory: :realistic_prosecution_case_identifier
    end
  end
end
