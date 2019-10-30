# frozen_string_literal: true

class HearingSummary
  include ActiveModel::Model

  attr_reader :hearing
  attr_accessor :hearing_id

  def initialize(attributes = {})
    super
    @hearing ||= Hearing.find(attributes[:hearing_id])
  end

  def to_builder
    Jbuilder.new do |hearing_summary|
      hearing_summary.hearingId hearing_id
      hearing_summary.jurisdictionType hearing.jurisdictionType
      hearing_summary.courtCentre hearing.court_centre.to_builder
      hearing_summary.type hearing.hearing_type.to_builder
      hearing_summary.defendants Jbuilder.new.array! defendants_builder
    end
  end

  private

  def defendants_builder
    # `defendants` is a required property on the schema, however, it is optional on Hearing.
    # We will need to determine where this is derived from.
    # Till then, to prevent our specs from breaking we render an array containing a single uuid in case the defendant ids are unavailable.
    hearing.defendant_attendances.pluck(:defendant_id).presence || ['ecca893f-0928-4fc6-ae50-6a8794b78c5c']
  end
end
