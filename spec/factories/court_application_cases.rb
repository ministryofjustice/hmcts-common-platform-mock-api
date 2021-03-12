FactoryBot.define do
  factory :court_application_case do
    prosecution_case_id { "8910ef88-75d8-42e0-8574-b44da52dc6d3" }
    is_sjp { true }
    prosecution_case_identifier { association :prosecution_case_identifier }
    case_status { "MyString" }

    after(:build) do |court_application_case|
      court_application_case.offences << build(:offence)
    end

    factory :realistic_court_application_case do
      prosecution_case_id { SecureRandom.uuid }
      is_sjp { Faker::Boolean.boolean }
      association :prosecution_case_identifier, factory: :realistic_prosecution_case_identifier
      case_status { Faker::String.random }

      after(:build) do |court_application_case|
        court_application_case.offences = [build(:offence_with_relationships)]
      end
    end
  end
end
