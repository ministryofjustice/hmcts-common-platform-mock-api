# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_alias do
    title { "MR" }
    firstName { "James" }
    middleName { "St" }
    lastName { "Parker" }
    legalEntityName { "Bot" }

    factory :realistic_defendant_alias do
      title { Person::TITLES.sample }
      firstName { Faker::Name.first_name }
      middleName { Faker::Name.middle_name }
      lastName { Faker::Name.last_name }
      legalEntityName { Faker::Company.name }
    end
  end
end
