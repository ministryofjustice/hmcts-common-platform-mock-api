# frozen_string_literal: true

class DefendantCustodyLocation < ApplicationRecord
  belongs_to :address

  validates :name, presence: true
  validates :address, presence: true
  validates :emailAddress, presence: true
  validates :locationType, presence: true, inclusion: %w[POLICESTATION PRISON DETENTIONCENTRE]

  def to_builder
    Jbuilder.new do |defendant_custody_location|
      defendant_custody_location.id id
      defendant_custody_location.name name
      defendant_custody_location.address address.to_builder
      defendant_custody_location.emailAddress emailAddress
      defendant_custody_location.locationType locationType
    end
  end
end
