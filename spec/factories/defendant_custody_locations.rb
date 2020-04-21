# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_custody_location, aliases: [:realistic_defendant_custody_location] do
    name { 'HMP Bellmarsh' }
    address
    emailAddress { 'hmp@example.com' }
    locationType { 'POLICESTATION' }
  end
end
