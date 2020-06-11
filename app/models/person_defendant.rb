# frozen_string_literal: true

class PersonDefendant < ApplicationRecord
  LICENCE_CODES = %w[FULL PROVISIONAL].freeze

  belongs_to :person
  belongs_to :defendant_custody_location, optional: true
  belongs_to :bail_status, optional: true
  belongs_to :employer_organisation, class_name: 'Organisation', optional: true

  validates :person, presence: true
  validates :driverLicenceCode, inclusion: LICENCE_CODES

  scope :by_name_and_dob, lambda { |params|
    joins(:person).merge(Person.by_name(params[:defendantName]).by_date_of_birth(params[:dateOfBirth]))
  }

  accepts_nested_attributes_for :person, reject_if: :all_blank

  def to_builder
    Jbuilder.new do |person_defendant|
      person_defendant.personDetails person.to_builder
      person_defendant.defendantCustodyLocation defendant_custody_location.to_builder if defendant_custody_location.present?
      person_defendant.bailStatus bail_status.to_builder if bail_status.present?
      person_defendant.bailConditions bailConditions
      person_defendant.bailReasons bailReasons
      person_defendant.custodyTimeLimit custodyTimeLimit&.to_date
      person_defendant.perceivedBirthYear perceivedBirthYear
      person_defendant.driverNumber driverNumber
      person_defendant.driverLicenceCode driverLicenceCode
      person_defendant.driverLicenseIssue driverLicenseIssue
      person_defendant.vehicleOperatorLicenceNumber vehicleOperatorLicenceNumber
      person_defendant.arrestSummonsNumber arrestSummonsNumber
      person_defendant.employerOrganisation employer_organisation.to_builder if employer_organisation.present?
      person_defendant.employerPayrollReference employerPayrollReference
    end
  end
end
