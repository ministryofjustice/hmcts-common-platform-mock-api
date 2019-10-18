# frozen_string_literal: true

FactoryBot.define do
  factory :person_defendant do
    person
    bail_status { nil }
    bailConditions { 'Random string' }
    bailReasons { 'Random string' }
    custodyTimeLimit { '2019-10-17 15:38:58' }
    perceivedBirthYear { 1 }
    driverNumber { 'Random string' }
    driverLicenceCode { 'PROVISIONAL' }
    driverLicenseIssue { 'Random string' }
    vehicleOperatorLicenceNumber { 'Random string' }
    arrestSummonsNumber { 'Random string' }
    employer_organisation { nil }
    employerPayrollReference { 'Random string' }
  end
end
