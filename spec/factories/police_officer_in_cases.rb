FactoryBot.define do
  factory :police_officer_in_case do
    person
    policeOfficerRank { 'Captain' }
    policeWorkerReferenceNumber { '4233223423' }
    policeWorkerLocationCode { 'AK' }
  end
end
