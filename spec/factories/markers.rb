# frozen_string_literal: true

FactoryBot.define do
  factory :marker do
    markerTypeid { SecureRandom.uuid }
    sequenceNumber { 'Random string' }
    markerTypeCode { 'Random string' }
    markerTypeLabel { 'Random string' }
    markerTypeName { 'Random string' }
    splitProsecutorCaseReference { 'Random string' }
  end
end
