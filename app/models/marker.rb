# frozen_string_literal: true

class Marker < ApplicationRecord
  validates :markerTypeid, presence: true
  validates :markerTypeCode, presence: true
  validates :markerTypeLabel, presence: true

  def to_builder
    Jbuilder.new do |marker|
      marker.id id
      marker.markerTypeid markerTypeid
      marker.markerTypeCode markerTypeCode
      marker.markerTypeDescription markerTypeLabel
    end
  end
end
