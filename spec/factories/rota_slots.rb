FactoryBot.define do
  factory :rota_slot do
    start_time { "2021-03-13T04:23:14+00:00" }
    duration { 1 }
    court_schedule_id { "1234" }
    session { "All Day (AD)" }
    oucode { "MyString" }
    court_room_id { 1 }
    court_centre_id { CourtCentre.all.sample.id }
    room_id { "MyString" }

    factory :realistic_rota_slot do
      start_time { Faker::Time.forward(days: 5).rfc3339 }
      duration { Faker::Number.within(range: 1..10) }
      court_schedule_id { "MyString" }
      session { RotaSlot::SESSIONS.sample }
      oucode { "MyString" }
      court_room_id { SecureRandom.uuid }
      court_centre_id { CourtCentre.all.sample.id }
      room_id { "MyString" }
    end
  end
end
