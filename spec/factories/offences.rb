# frozen_string_literal: true

FactoryBot.define do
  factory :offence do
    offenceDefinitionId { SecureRandom.uuid }
    offenceCode { 'Random string' }
    offenceTitle { 'Random string' }
    offenceTitleWelsh { 'Llinyn ar hap' }
    offenceLegislation { 'Random string' }
    offenceLegislationWelsh { 'Llinyn ar hap' }
    modeOfTrial { 'Random string' }
    wording { 'Random string' }
    wordingWelsh { 'Llinyn ar hap' }
    startDate { '2019-10-17 14:06:13' }
    endDate { '2019-10-17 14:06:13' }
    arrestDate { '2019-10-17 14:06:13' }
    chargeDate { '2019-10-17 14:06:13' }
    dateOfInformation { '2019-10-17 14:06:13' }
    orderIndex { 1 }
    count { 1 }
    convictionDate { '2019-10-17 14:06:13' }
    aquittalDate { '2019-10-17 14:06:13' }
    isDisposed { false }
    isDiscontinued { false }
    isIntroduceAfterInitialProceedings { false }
    custody_time_limit { nil }
    splitProsecutorCaseReference { 'Random string' }
    mergedProsecutionCaseReference { 'Random string' }
  end
end
