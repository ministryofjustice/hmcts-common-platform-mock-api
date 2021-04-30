FactoryBot.define do
  factory :defendant_judicial_result do
    master_defendant_id { "4fccf5ef-4862-4da5-ab8f-c9df3c977caf" }
    judicial_result { association :judicial_result }

    factory :realistic_defendant_judicial_result do
      master_defendant_id { SecureRandom.uuid }
      association :judicial_result, factory: :realistic_judicial_result
    end
  end
end
