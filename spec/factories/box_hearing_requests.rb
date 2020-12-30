# frozen_string_literal: true

FactoryBot.define do
  factory :box_hearing_request do
    jurisdictionType { 'CROWN' }
    court_centre_id { '6131bd34-33d9-3d1e-8152-8b5a2084f1bd' }
    applicationDueDate { '2020-12-29 11:10:55' }
    virtualAppointmentTime { '2020-12-29 11:10:55' }
    sendAppointmentLetter { false }
  end
end
