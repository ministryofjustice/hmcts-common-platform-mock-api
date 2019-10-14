FactoryBot.define do
  factory :notified_plea do
    offenceId { SecureRandom.uuid }
    notifiedPleaDate { '2019-10-14' }
    notifiedPleaValue { 'NOTIFIED_GUILTY' }
  end
end
