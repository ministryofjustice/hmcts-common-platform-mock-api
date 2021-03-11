class SeedingHearing < ApplicationRecord

  JURISDICTION_TYPES =  %w[MAGISTRATES CROWN].freeze

  validates :seeding_hearing_id, presence: true
  validates :jurisdiction_type, presence: true

  def to_builder
    Jbuilder.new do |seeding_hearing|
      seeding_hearing.seedingHearingId seeding_hearing_id
      seeding_hearing.jurisdictionType jurisdiction_type
      seeding_hearing.sittingDay sitting_day
    end
  end
end
