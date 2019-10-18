FactoryBot.define do
  factory :judicial_result_prompt do
    label { 'Random String' }
    isAvailableForCourtExtract { false }
    welshLabel { 'Llinyn ar hap' }
    value { 'Random String' }
    qualifier { 'Random String' }
    durationSequence { 1 }
    promptSequence { 1 }
    promptReference { 'Random String' }
    totalPenaltyPoints { 1 }
    isFinancialImposition { false }
  end
end