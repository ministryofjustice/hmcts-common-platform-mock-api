# frozen_string_literal: true

class CourtApplication < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  belongs_to :court_application_party
  belongs_to :court_application_payment, optional: true
  belongs_to :court_application_type
  belongs_to :hearing

  has_many :judicial_results, dependent: :destroy

  validates :applicationReceivedDate, presence: true
  validates :court_application_party, presence: true
  validates :applicationStatus, presence: true, inclusion: %w[DRAFT LISTED FINALISED]

  def to_builder
    Jbuilder.new do |court_application|
      court_application.id id
      court_application.applicationReceivedDate applicationReceivedDate.to_date
      court_application.applicationReference applicationReference
      court_application.applicant court_application_party.to_builder
      court_application.type court_application_type.to_builder
      court_application.parentApplicationId parentApplicationId
      court_application.applicationParticulars applicationParticulars
      court_application.courtApplicationPayment court_application_payment.to_builder if court_application_payment.present?
      court_application.applicationDecisionSoughtByDate applicationDecisionSoughtByDate.to_date
      court_application.applicationStatus applicationStatus
      court_application.outOfTimeReasons outOfTimeReasons
      court_application.judicialResults array_builder(judicial_results)
      court_application.subject court_application_party.to_builder
    end
  end
end
