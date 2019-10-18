# frozen_string_literal: true

class AllocationDecision < ApplicationRecord
  belongs_to :court_indicated_sentence

  validates :originatingHearingId, presence: true
  validates :offenceId, presence: true
  validates :motReasonId, presence: true
  validates :motReasonDescription, presence: true
  validates :motReasonCode, presence: true
  validates :allocationDecisionDate, presence: true
  validates :isSection22ALowValueShoplifting, inclusion: [true, false]
  validates :isDamageValueUnder5000, inclusion: [true, false]
  validates :isTreatedAsIndictableOnly, inclusion: [true, false]
  validates :sentencingIndicationRequested, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |allocation_decision|
      allocation_decision.originatingHearingId originatingHearingId
      allocation_decision.offenceId offenceId
      allocation_decision.motReasonId motReasonId
      allocation_decision.motReasonDescription motReasonDescription
      allocation_decision.motReasonCode motReasonCode
      allocation_decision.allocationDecisionDate allocationDecisionDate.to_date
      allocation_decision.isSection22ALowValueShoplifting isSection22ALowValueShoplifting
      allocation_decision.isDamageValueUnder5000 isDamageValueUnder5000
      allocation_decision.isTreatedAsIndictableOnly isTreatedAsIndictableOnly
      allocation_decision.sentencingIndicationRequested sentencingIndicationRequested
    end
 end
end
