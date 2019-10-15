class Person < ApplicationRecord

  LANGUAGES = %w(ENGLISH WELSH)
  GENDERS = %w(MALE FEMALE NOT_KNOWN NOT_SPECIFIED)
  TITLES = %w(MR MRS MISS MS)

  belongs_to :ethnicity, optional: true
  belongs_to :address, optional: true
  belongs_to :contact_number, optional: true

  validates :lastName, presence: true
  validates :title, inclusion: TITLES
  validates :gender, presence: true, inclusion: GENDERS
  validates :documentationLanguageNeeds, inclusion: LANGUAGES


  def to_builder
    Jbuilder.new do |person|
      person.title title
      person.firstName firstName
      person.middleName middleName
      person.lastName lastName
      person.dateOfBirth dateOfBirth.to_date
      person.nationalityId nationalityId
      person.nationalityCode nationalityCode
      person.nationalityDescription nationalityDescription
      person.additionalNationalityId additionalNationalityId
      person.additionalNationalityCode additionalNationalityCode
      person.additionalNationalityDescription additionalNationalityDescription
      person.disabilityStatus disabilityStatus
      person.ethnicity ethnicity.to_builder if ethnicity.present?
      person.gender gender
      person.interpreterLanguageNeeds interpreterLanguageNeeds
      person.documentationLanguageNeeds documentationLanguageNeeds
      person.nationalInsuranceNumber nationalInsuranceNumber
      person.occupation occupation
      person.occupationCode occupationCode
      person.specificRequirements specificRequirements
      person.address address.to_builder if address.present?
      person.contact contact_number.to_builder if contact_number.present?
    end
  end
end
