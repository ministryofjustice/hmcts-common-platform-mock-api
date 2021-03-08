FactoryBot.define do
  factory :box_hearing_request do
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    jurisdiction_type { "CROWN" }
    application_due_date { "2021-03-08T09:32:36+00:00" }
    virtual_appointment_time { "2021-03-08T09:32:36+00:00" }
    send_appointment_letter { false }

    factory :realistic_box_hearing_request do
      court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
      jurisdiction_type { BoxHearingRequest::JURISDICTION_TYPES.sample }
      application_due_date { Faker::Date.forward.rfc3339 }
      virtual_appointment_time { Faker::Date.forward.rfc3339 }
      send_appointment_letter { Faker::Boolean.boolean }
    end
  end
end
