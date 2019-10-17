FactoryBot.define do
  factory :linked_defendant do
    prosecutionCaseId { SecureRandom.uuid }
    defendantId { SecureRandom.uuid }
  end
end
