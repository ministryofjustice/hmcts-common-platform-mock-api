class CommittingCourt < ApplicationRecord
  COURT_TYPES = %w[MAGISTRATES CROWN].freeze

  validates :court_centre_id, presence: true
  validates :court_house_name, presence: true

  def to_builder
    Jbuilder.new do |committing_court|
      committing_court.courtCentreId court_centre_id
      committing_court.courtHouseType court_house_type
      committing_court.courtHouseCode court_house_code
      committing_court.courtHouseName court_house_name
      committing_court.courtHouseShortName court_house_short_name
    end
  end
end
