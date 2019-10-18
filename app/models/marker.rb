# frozen_string_literal: true

class Marker < ApplicationRecord
  validates :markerTypeid, presence: true
  validates :markerTypeCode, presence: true
  validates :markerTypeLabel, presence: true
  validates :markerTypeName, presence: true

  def to_builder
    Jbuilder.new do |marker|
      marker.id id
      marker.markerTypeid markerTypeid
      marker.sequenceNumber sequenceNumber
      marker.markerTypeCode markerTypeCode
      marker.markerTypeLabel markerTypeLabel
      marker.markerTypeName markerTypeName
      marker.splitProsecutorCaseReference splitProsecutorCaseReference
    end
  end
end
