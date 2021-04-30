FactoryBot.define do
  factory :defendant_case do
    defendant_id { "58617739-aa13-4bb6-820a-eddc48602d2f" }
    case_id { "dd7a5b63-65ad-42ab-a516-a13208c8b838" }
    case_reference { "AOPLWLMRTR" }

    factory :realistic_defendant_case do
      defendant_id { SecureRandom.uuid }
      case_id { SecureRandom.uuid }
      case_reference { Faker::Alphanumeric.alpha(number: 10).upcase }
    end
  end
end
