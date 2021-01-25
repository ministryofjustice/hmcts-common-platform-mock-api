# frozen_string_literal: true

class AllocationDecision < ApplicationRecord
  DESCRIPTIONS = ["Offence triable only by court martial",
                  "Indictable only offence",
                  "No mode of Trial Either way offence",
                  "Defendant consents to summary trial",
                  "Commanding Officer orders trial by court martial",
                  "Defendant chooses trial by court martial 1",
                  "Defendant elects trial by jury",
                  "Summary only offence",
                  "Youth offence triable on indictment only (homicide relevant firearms dangerousness)",
                  "Youth Court directs trial by jury (grave crime)",
                  "Low value offence triable summarily only",
                  "Indictable only (previous convictions relevant firearms offence)",
                  "Court directs trial by jury"].freeze

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
