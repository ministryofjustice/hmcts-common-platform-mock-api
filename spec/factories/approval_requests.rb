FactoryBot.define do
  factory :approval_request do
    hearing_id { "2229c152-0996-47ca-a58c-92ec6ede6618" }
    user_id { "b2bab07b-91e8-4e18-b3eb-f60e50f10ad4" }
    request_approval_time { "2020-10-02T10:00:00-05:00" }
    approval_type { "CHANGE" }

    factory :realistic_approval_request do
      hearing_id { SecureRandom.uuid }
      user_id { SecureRandom.uuid }
      request_approval_time { Faker::Date.backward.rfc3339 }
      approval_type { ApprovalRequest::APPROVAL_TYPES.sample }
    end
  end
end
