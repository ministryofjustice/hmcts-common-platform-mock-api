# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    title { 'MISS' }
    firstName { 'Alfredine' }
    middleName { 'Treutel' }
    lastName { 'Parker' }
    dateOfBirth { '1971-05-12' }
    nationalityId { 'a1c2f090-4fb6-4c50-a08d-3ef23aac83da' }
    nationalityCode { 'Gibraltar' }
    nationalityDescription { 'Good habits formed at youth make all the difference' }
    additionalNationalityId { '12b33a32-8857-4602-b7fa-47280bdc660d' }
    additionalNationalityCode { 'Irish' }
    additionalNationalityDescription { 'The unexamined life is not worth living.' }
    disabilityStatus { 'blind' }
    gender { 'NOT_SPECIFIED' }
    interpreterLanguageNeeds { 'Swedish' }
    documentationLanguageNeeds { 'ENGLISH' }
    nationalInsuranceNumber { 'BN102966C' }
    occupation { 'Global Real-Estate Strategist' }
    occupationCode { '4033' }
    specificRequirements { 'Unleash back-end relationships' }
  end
end
