# frozen_string_literal: true

class Person < ApplicationRecord
  LANGUAGES = %w[ENGLISH WELSH].freeze
  GENDERS = %w[MALE FEMALE NOT_KNOWN NOT_SPECIFIED].freeze
  TITLES = %w[MR MRS MISS MS].freeze
  NINO_REGEXP = /^[A-CEGHJ-PR-TW-Z]{1}[A-CEGHJ-NPR-TW-Z]{1}[0-9]{6}[A-D]{1}$/.freeze

  scope :by_name, ->(full_name) { where(full_name.slice(:firstName, :lastName, :middleName)) }
  scope :by_date_of_birth, ->(date) { where(dateOfBirth: date) }

  belongs_to :ethnicity, optional: true
  belongs_to :address, optional: true
  belongs_to :contact_number, optional: true

  validates :lastName, presence: true
  validates :title, inclusion: TITLES
  validates :gender, presence: true, inclusion: GENDERS
  validates :documentationLanguageNeeds, inclusion: LANGUAGES

  def name
    [firstName, middleName, lastName].compact.join(' ')
  end

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
