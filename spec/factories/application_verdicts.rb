FactoryBot.define do
  factory :application_verdict do
    originating_hearing_id { "60c1586e-b77f-4e63-bbce-ced4565acd35" }
    application_id { "d6ac9252-859b-43fa-a3fc-da31f630ef27" }
    verdict_date { "2019-10-14" }
    verdict_type { association :verdict_type }
    lesser_or_alternative_offence { association :lesser_or_alternative_offence }
    jurors { association :jurors }

    factory :realistic_application_verdict do
      originating_hearing_id { SecureRandom.uuid }
      application_id { SecureRandom.uuid }
      verdict_date { Faker::Date.backward }
      association :verdict_type, factory: :realistic_verdict_type
      association :lesser_or_alternative_offence, factory: :realistic_lesser_or_alternative_offence
      association :jurors, factory: :realistic_jurors
    end
  end
end
