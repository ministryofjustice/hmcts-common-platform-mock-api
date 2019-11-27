# frozen_string_literal: true

class CourtApplicationParty < ApplicationRecord
  include BuilderMappable
  belongs_to :defendant, optional: true
  belongs_to :organisation, optional: true
  belongs_to :person, optional: true
  belongs_to :prosecuting_authority, optional: true
  belongs_to :representation_organisation, class_name: 'Organisation', optional: true

  has_many :associated_people

  def to_builder
    Jbuilder.new do |court_application_party|
      court_application_party.id id
      court_application_party.synonym synonym
      court_application_party.personDetails person.to_builder if person.present?
      court_application_party.organisation organisation.to_builder if organisation.present?
      court_application_party.organisationPersons array_builder(associated_people)
      court_application_party.prosecutingAuthority prosecuting_authority.to_builder if prosecuting_authority.present?
      court_application_party.defendant defendant.to_builder if defendant.present?
      court_application_party.representationOrganisation representation_organisation.to_builder if defendant.present?
    end
  end
end
