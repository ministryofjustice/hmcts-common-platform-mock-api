FactoryBot.define do
  factory :indicated_plea do
    offenceId { SecureRandom.uuid }
    originatingHearingId { SecureRandom.uuid }
    indicatedPleaDate { '2019-10-14' }
    indicatedPleaValue { 'NO_INDICATION' }
    source { 'ONLINE' }
  end
end
