# frozen_string_literal: true

FactoryBot.define do
  factory :contact_number do
    home { "0500 993814" }
    work { "024 0862 0169" }
    mobile { "0378 383 9553" }
    primaryEmail { "christian_renner@wildermanswift.name" }
    secondaryEmail { "delbert@keeling.org" }
    fax { "024 0862 0169" }
    factory :realistic_contact_number do
      home { Faker::PhoneNumber.cell_phone_with_country_code }
      work { Faker::PhoneNumber.cell_phone_with_country_code }
      mobile { Faker::PhoneNumber.cell_phone }
      primaryEmail { Faker::Internet.email }
      secondaryEmail { Faker::Internet.email }
      fax { Faker::PhoneNumber.phone_number }
    end
  end
end
