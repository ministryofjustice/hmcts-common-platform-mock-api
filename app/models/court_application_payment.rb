# frozen_string_literal: true

class CourtApplicationPayment < ApplicationRecord
  validates :isFeePaid, inclusion: [true, false]
  validates :isFeeExempt, inclusion: [true, false]
  validates :isFeeUndertakingAttached, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |court_application_payment|
      court_application_payment.isFeePaid isFeePaid
      court_application_payment.isFeeUndertakingAttached isFeeUndertakingAttached
      court_application_payment.isFeeExempt isFeeExempt
      court_application_payment.paymentReference paymentReference
    end
  end
end
