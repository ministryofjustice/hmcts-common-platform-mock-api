# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_result, aliases: [:realistic_judicial_result] do
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
    amendmentDate { '2019-10-16 10:11:02' }
    qualifier { 'Random String' }
    resultText { 'Random String' }
    cjsCode { 'Random String' }
    postHearingCustodyStatus { 'Random String' }
    rank { 1 }
    orderedDate { '2019-10-16 10:11:02' }
    lastSharedDateTime { 'Random String' }
    terminatesOffenceProceedings { false }
    isLifeDuration { false }
    isPublishedAsAPrompt { false }
    isExcludedFromResults { false }
    isAlwaysPublished { false }
    isUrgent { false }
    isD20 { false }
    approvedDate { '2019-10-16 10:11:02' }
    category { 'INTERMEDIARY' }
  end
end
