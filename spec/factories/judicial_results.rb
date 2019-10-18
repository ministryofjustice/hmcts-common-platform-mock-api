FactoryBot.define do
  factory :judicial_result do
    judicialResultId { SecureRandom.uuid }
    orderedHearingId { SecureRandom.uuid }
    label { 'Random String' }
    welshLabel { 'Llinyn ar hap' }
    isAdjournmentResult { false }
    isFinancialResult { false }
    isConvictedResult { false }
    isAvailableForCourtExtract { false }
    isDeleted { false }
    amendmentReasonId { SecureRandom.uuid }
    amendmentReason { 'Random String' }
    amendmentDate { "2019-10-16 10:11:02" }
    qualifier { 'Random String' }
    resultText { 'Random String' }
    cjsCode { 'Random String' }
    postHearingCustodyStatus { 'Random String' }
    rank { 1 }
    orderedDate { "2019-10-16 10:11:02" }
    lastSharedDateTime { 'Random String' }
    terminatesOffenceProceedings { false }
    isLifeDuration { false }
    isPublishedAsAPrompt { false }
    isExcludedFromResults { false }
    isAlwaysPublished { false }
    isUrgent { false }
    isD20 { false }
    court_clerk { nil }
    delegated_powers { nil }
    four_eyes_approval { nil }
    approvedDate { "2019-10-16 10:11:02" }
    category { 'INTERMEDIARY' }
    next_hearing { nil }
    duration_element { nil }
    factory :judicial_result_with_prompt do
        after(:build) do |judicial_result|
            judicial_result.judicial_result_prompts << FactoryBot.build(:judicial_result_prompt, judicial_result: nil)
        end
    end
  end
end
