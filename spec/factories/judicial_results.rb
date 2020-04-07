# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_result, aliases: [:realistic_judicial_result] do
    judicialResultId { SecureRandom.uuid }
    judicialResultTypeId { SecureRandom.uuid }
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

    factory :judicial_result_with_relationships do
      association :court_clerk, factory: :delegated_powers
      association :delegated_powers, factory: :delegated_powers
      association :four_eyes_approval, factory: :delegated_powers
      association :next_hearing, factory: :next_hearing
      association :duration_element, factory: :judicial_result_prompt_duration_element
      after(:build) do |judicial_result, _evaluator|
        judicial_result.judicial_result_prompts << build(:judicial_result_prompt)
      end
    end
  end
end
