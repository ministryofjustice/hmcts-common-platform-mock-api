FactoryBot.define do
  factory :master_defendant do
    master_defendant_id { "8dc9aed0-b4e3-428e-8448-e9b0422ce88d" }
    person_defendant { association :person_defendant }
    is_youth { true }
    pnc_id { "54619170-2" }
    prosecution_authority_reference { "perspiciatis" }

    after(:build) do |master_defendant|
      master_defendant.associated_people << build(:associated_person)
      master_defendant.defendant_cases << build(:defendant_case)
    end

    factory :realistic_master_defendant do
      master_defendant_id { SecureRandom.uuid }
      association :person_defendant, factory: :realistic_person_defendant
      is_youth { Faker::Boolean.boolean }
      pnc_id { Faker::Code.rut }
      prosecution_authority_reference { Faker::Lorem.word }

      after(:build) do |realistic_master_defendant|
        realistic_master_defendant.associated_people << build(:associated_person)
        realistic_master_defendant.defendant_cases << build(:defendant_case)
      end
    end
  end
end
