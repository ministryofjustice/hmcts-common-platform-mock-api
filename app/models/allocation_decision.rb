# frozen_string_literal: true

class AllocationDecision < ApplicationRecord
  VALUES = { "Offence triable only by court martial": 8,
             "Indictable only offence": 2,
             "No mode of Trial - Either way offence": 7,
             "Defendant consents to summary trial": 3,
             "Commanding Officer orders trial by court martial": 10,
             "Defendant chooses trial by court martial 1": 9,
             "Defendant elects trial by jury": 4,
             "Summary - only offence": 1,
             "Youth - offence triable on indictment only (homicide / relevant firearms / dangerousness)": 2,
             "Youth - Court directs trial by jury (grave crime)": 5,
             "Low value offence triable summarily only": 6,
             "Indictable only (previous convictions / relevant firearms offence)": 2,
             "Court directs trial by jury": 5 }.freeze

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
