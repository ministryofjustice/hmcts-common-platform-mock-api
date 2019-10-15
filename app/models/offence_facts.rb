class OffenceFacts < ApplicationRecord
  VEHICLE_CODES = %w(LARGE_GOODS_VEHICLE PASSENGER_CARRYING_VEHICLE OTHER)

  validates :vehicleCode, inclusion: VEHICLE_CODES

  def to_builder
    Jbuilder.new do |offence_facts|
      offence_facts.vehicleRegistration vehicleRegistration
      offence_facts.alcoholReadingAmount alcoholReadingAmount
      offence_facts.alcoholReadingMethodCode alcoholReadingMethodCode
      offence_facts.alcoholReadingMethodDescription alcoholReadingMethodDescription
      offence_facts.vehicleCode vehicleCode
    end
  end
end
