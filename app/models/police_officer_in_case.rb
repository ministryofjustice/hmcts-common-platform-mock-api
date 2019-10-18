# frozen_string_literal: true

class PoliceOfficerInCase < ApplicationRecord
  belongs_to :person
  validates :person, presence: true
  validates :policeOfficerRank, presence: true
  validates :policeWorkerReferenceNumber, presence: true
  validates :policeWorkerLocationCode, presence: true

  def to_builder
    Jbuilder.new do |police_officer_in_case|
      police_officer_in_case.personDetails person.to_builder
      police_officer_in_case.policeOfficerRank policeOfficerRank
      police_officer_in_case.policeWorkerReferenceNumber policeWorkerReferenceNumber
      police_officer_in_case.policeWorkerLocationCode policeWorkerLocationCode
    end
  end
end
