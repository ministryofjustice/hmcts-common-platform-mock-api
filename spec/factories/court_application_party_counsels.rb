# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party_counsel do
    applicationId { SecureRandom.uuid }
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    status { "Litigator" }
    after(:build) do |court_application_party_counsel|
      court_application_party_counsel.attendance_days << build(:attendance_day)
    end

    factory :court_application_party_counsel_with_relationships do
      after(:build) do |court_application_party_counsel|
        court_application_party_counsel.court_application_parties << FactoryBot.create(:court_application_party_with_relationships)
      end
    end
  end
end
