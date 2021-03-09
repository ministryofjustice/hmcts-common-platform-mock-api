FactoryBot.define do
  factory :court_order_subject do
    master_defendant_id { "43c57732-34b8-45a5-a458-e4e4463dbc59" }
    organisation_name { "Haley, Gerlach and Kuhn" }
    title { "MR" }
    first_name { "Georgine" }
    middle_name { "McKenzie" }
    last_name { "Brakus" }
    date_of_birth { "1972-05-26" }
    address_line_1 { "226 Huel Harbors" }
    pnc_id { "73591755-2" }
    cro_number { "B0000008XW" }

    factory :realistic_court_order_subject do
      master_defendant_id { SecureRandom.uuid }
      organisation_name { Faker::Company.name }
      title { Person::TITLES.sample }
      first_name { Faker::Name.first_name }
      middle_name { Faker::Name.middle_name }
      last_name { Faker::Name.last_name }
      date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
      address_line_1 { Faker::Address.street_address }
      pnc_id { Faker::Code.rut }
      cro_number { Faker::Code.asin }
    end
  end
end
