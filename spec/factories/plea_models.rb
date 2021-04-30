FactoryBot.define do
  factory :plea_model do
    prosecution_case_id { "ef0ea91d-326d-418a-9fb9-a3481f1b2e05" }
    defendant_id { "35bd5a88-6ea1-491c-823e-aac7743850f0" }
    offence_id { "e438a910-a0ca-47c3-9903-0ac7ab8c4ec3" }
    indicated_plea { association :indicated_plea }
    plea { association :plea }
    allocation_decision { association :allocation_decision }
    application_id { "2fafe402-a333-402d-af87-b1c1f2ca6c1e" }

    factory :realistic_plea_model do
      prosecution_case_id { SecureRandom.uuid }
      defendant_id { SecureRandom.uuid }
      offence_id { SecureRandom.uuid }
      association :indicated_plea, factory: :realistic_indicated_plea
      association :plea, factory: :realistic_plea
      association :allocation_decision, factory: :realistic_allocation_decision
      application_id { SecureRandom.uuid }
    end
  end
end
