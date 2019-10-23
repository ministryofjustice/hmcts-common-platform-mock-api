# frozen_string_literal: true

class HearingDay < ApplicationRecord
  validates :sittingDay, presence: true
  validates :listedDurationMinutes, presence: true

  def to_builder
    Jbuilder.new do |hearing_day|
      hearing_day.sittingDay sittingDay
      hearing_day.listingSequence listingSequence
      hearing_day.listedDurationMinutes listedDurationMinutes
    end
  end
end
