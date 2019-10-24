# frozen_string_literal: true

class CourtApplicationParty < ApplicationRecord
  belongs_to :defendant
  belongs_to :organisation
  belongs_to :person
  belongs_to :prosecuting_authority
  belongs_to :representation_organisation, class_name: 'Organisation'

  has_many :associated_people

  def to_builder
    Jbuilder.new do |court_application_party|
      court_application_party.id id
      court_application_party.personDetails person.to_builder
      court_application_party.organisationPersons Jbuilder.new.array! associated_people_builder if associated_people.present?
      court_application_party.defendant defendant.to_builder
      court_application_party.organisation organisation.to_builder
      court_application_party.prosecutingAuthority prosecuting_authority.to_builder
      court_application_party.representationOrganisation representation_organisation.to_builder
    end
  end

  private

  def associated_people_builder
    associated_people.map do |associated_person|
      associated_person.to_builder.attributes!
    end
  end
end
