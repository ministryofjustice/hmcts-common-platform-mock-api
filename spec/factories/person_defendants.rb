# frozen_string_literal: true

FactoryBot.define do
  factory :person_defendant do
    person
    bail_status { nil }
    bailConditions { 'Random string' }
    bailReasons { 'Random string' }
    custodyTimeLimit { '2019-10-17 15:38:58' }
    perceivedBirthYear { 1999 }
    driverNumber { 'Random string' }
    driverLicenceCode { 'PROVISIONAL' }
    driverLicenseIssue { 'Random string' }
    vehicleOperatorLicenceNumber { 'Random string' }
    arrestSummonsNumber { 'Random string' }
    employer_organisation { nil }
    employerPayrollReference { 'Random string' }

    factory :person_defendant_with_relationships do
      association :bail_status, factory: :bail_status_with_relationships
      association :employer_organisation, factory: :organisation_with_relationships
      association :person, factory: :person_with_relationships
    end

    factory :realistic_person_defendant do
      association :person, factory: :realistic_person
      association :bail_status, factory: :realistic_bail_status
      association :custodyTimeLimit, factory: :realistic_custody_time_limit
      association :employer_organisation, factory: :realistic_organisation
      bailConditions { Faker::Lorem.sentence }
      bailReasons { Faker::Lorem.sentence }
      perceivedBirthYear { Faker::Number.between(from: 1950, to: 2010) }
      driverNumber { Faker::Lorem.sentence }
      driverLicenceCode { PersonDefendant::LICENCE_CODES.sample }
      driverLicenseIssue { Faker::Lorem.sentence }
      vehicleOperatorLicenceNumber { Faker::Alphanumeric.alphanumeric(number: 7).upcase }
      arrestSummonsNumber { Faker::Alphanumeric.alphanumeric(number: 12).upcase }
      employerPayrollReference { Faker::Alphanumeric.alphanumeric(number: 9).upcase }
    end
  end
end
