# frozen_string_literal: true

FactoryBot.define do
  factory :court_centre do
    name { 'Random string' }
    welshName { 'Llinyn ar hap' }
    roomId { SecureRandom.uuid }
    roomName { 'Grand Hall' }
    welshRoomName { 'Neuadd y Grand' }
    address { nil }
  end
end
