# frozen_string_literal: true

class AllocationDecision < ApplicationRecord
  DESCRIPTIONS = %w[Offence_triable_only_by_court_martial
                    Indictable_only_offence
                    No_mode_of_Trial_Either_way_offence
                    Defendant_consents_to_summary_trial
                    Commanding_Officer_orders_trial_by_court_martial
                    Defendant_chooses_trial_by_court_martial_1
                    Defendant_elects_trial_by_jury
                    Summary_only_offence
                    Youth_offence_triable_on_indictment_only_(homicide_relevant_firearms_dangerousness)
                    Youth_Court_directs_trial_by_jury_(grave_crime)
                    Low_value_offence_triable_summarily_only
                    Indictable_only_(previous_convictions_relevant_firearms_offence)
                    Court_directs_trial_by_jury].freeze

  CODES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].freeze

  belongs_to :court_indicated_sentence, optional: true

  belongs_to :hearing
  belongs_to :offence

  validates :motReasonId, presence: true
  validates :motReasonDescription, presence: true
  validates :motReasonCode, presence: true
  validates :sequenceNumber, presence: true
  validates :allocationDecisionDate, presence: true
  validates :isSection22ALowValueShoplifting, inclusion: [true, false]
  validates :isDamageValueUnder5000, inclusion: [true, false]
  validates :isTreatedAsIndictableOnly, inclusion: [true, false]
  validates :sentencingIndicationRequested, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |allocation_decision|
      allocation_decision.originatingHearingId hearing_id
      allocation_decision.offenceId offence_id
      allocation_decision.motReasonId motReasonId
      allocation_decision.motReasonDescription motReasonDescription
      allocation_decision.motReasonCode motReasonCode
      allocation_decision.sequenceNumber sequenceNumber
      allocation_decision.allocationDecisionDate allocationDecisionDate.to_date
      allocation_decision.courtIndicatedSentence court_indicated_sentence.to_builder if court_indicated_sentence.present?
    end
  end
end
