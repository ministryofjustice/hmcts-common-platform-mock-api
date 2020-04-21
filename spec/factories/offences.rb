# frozen_string_literal: true

require 'faker/offence'

FactoryBot.define do
  factory :offence, aliases: [:realistic_offence] do
    offenceDefinitionId { SecureRandom.uuid }
    offenceCode { 'Random string' }
    dvlaCode { 'Random string' }
    offenceTitle { Faker::Offence.name }
    offenceTitleWelsh { Faker::Offence.name }
    offenceLegislation { Faker::Offence.act }
    offenceLegislationWelsh { Faker::Offence.act }
    modeOfTrial { 'Random string' }
    wording { 'Random string' }
    wordingWelsh { 'Llinyn ar hap' }
    startDate { '2019-10-17 14:06:13' }
    endDate { '2019-10-17 14:06:13' }
    arrestDate { '2019-10-17 14:06:13' }
    chargeDate { '2019-10-17 14:06:13' }
    laidDate { '2019-10-17 14:06:13' }
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
    proceedingsConcluded { false }
    pendingCBPW { false }
    civilOffence { false }

    factory :offence_with_relationships do
      notified_plea
      indicated_plea
      association :allocation_decision, factory: :allocation_decision_with_relationships
      association :laa_reference, factory: :laa_reference
      association :custody_time_limit, factory: :custody_time_limit
      association :plea, factory: :plea_with_relationships
      association :verdict, factory: :verdict_with_relationships
      association :offence_facts, factory: :offence_facts
      after(:build) do |offence|
        offence.victims << build(:person_with_relationships)
        offence.judicial_results << build(:judicial_result_with_relationships)
      end
    end
  end
end
