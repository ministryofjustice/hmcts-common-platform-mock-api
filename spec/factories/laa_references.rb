# frozen_string_literal: true

FactoryBot.define do
  factory :laa_reference do
    applicationReference { "Random string" }
    offenceLevelStatus { "Random string" }
    statusId { SecureRandom.uuid }
    statusCode { "Random string" }
    statusDescription { "Random string" }
    statusDate { "2019-10-16 14:26:26" }
    effectiveStartDate { "2019-10-16 14:26:26" }
    effectiveEndDate { "2019-10-16 14:26:26" }
  end
end
