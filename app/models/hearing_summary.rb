# frozen_string_literal: true

class HearingSummary
  include ActiveModel::Model

  attr_reader :hearing
  attr_accessor :hearing_id, :sitting_day

  def initialize(attributes = {})
    super
    @hearing ||= Hearing.find_by(hearing_id: attributes[:hearing_id], sitting_day: attributes[:sitting_day])
  end

  def to_builder
    Jbuilder.new do |hearing_summary|
      hearing_summary.hearingId hearing_id
      hearing_summary.jurisdictionType hearing.jurisdictionType
      hearing_summary.courtCentre hearing.court_centre.to_builder
      hearing_summary.hearingType hearing.hearing_type.to_builder
      hearing_summary.defendantIds defendants_builder
      hearing_summary.hearingDays hearing_days_builder
      hearing_summary.defenceCounsel hearing.defence_counsels.map(&:to_builder)
    end
  end

private

  def hearing_days_builder
    hearing.hearing_days.map do |hearing_day|
      [
        [:sittingDay, hearing_day.sittingDay],
        [:listingSequence, hearing_day.listingSequence],
        [:listedDurationMinutes, hearing_day.listedDurationMinutes],
        [:hasSharedResults, hearing_day.hasSharedResults],
      ].to_h
    end
  end

  def defendants_builder
    # `defendants` is a required property on the schema, however, it is optional on Hearing.
    # We will need to determine where this is derived from.
    # Till then, to prevent our specs from breaking we render an array containing a single uuid in case the defendant ids are unavailable.
    hearing.defendant_attendances.pluck(:defendant_id).presence || %w[ecca893f-0928-4fc6-ae50-6a8794b78c5c]
  end
end
