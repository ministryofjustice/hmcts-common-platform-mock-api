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

    factory :realistic_person do
      title { Person::TITLES.sample }
      firstName { Faker::Name.first_name }
      middleName { Faker::Name.middle_name }
      lastName { Faker::Name.last_name }
      dateOfBirth { Faker::Date.birthday(min_age: 18, max_age: 65) }
      nationalityId { SecureRandom.uuid }
      nationalityCode { Faker::Address.country_code }
      nationalityDescription { Faker::Address.country_by_code(code: nationalityCode) }
      additionalNationalityId { SecureRandom.uuid }
      additionalNationalityCode { Faker::Address.country_code }
      additionalNationalityDescription { Faker::Address.country_by_code(code: additionalNationalityCode) }
      disabilityStatus { Faker::Lorem.word }
      gender { Person::GENDERS.sample }
      interpreterLanguageNeeds { Faker::Nation.language }
      documentationLanguageNeeds { Person::LANGUAGES.sample }
      nationalInsuranceNumber { Faker::Base.regexify(Person::NINO_REGEXP) }
      occupation { Faker::Company.profession }
      occupationCode { Faker::Company.sic_code }
      specificRequirements { Faker::Lorem.word }
      association :address, factory: :realistic_address
      association :contact_number, factory: :realistic_contact_number
      association :ethnicity, factory: :realistic_ethnicity
    end
  end
end
