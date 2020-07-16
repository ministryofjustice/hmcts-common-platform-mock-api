# frozen_string_literal: true

class CourtApplication < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable
  belongs_to :application_type, class_name: 'CourtApplicationType'
  belongs_to :court_application_party
  belongs_to :court_application_outcome, optional: true
  belongs_to :court_application_payment, optional: true
  has_many :court_application_respondents
  has_many :judicial_results

  validates :application_type, presence: true
  validates :applicationReceivedDate, presence: true
  validates :court_application_party, presence: true
  validates :applicationStatus, presence: true, inclusion: %w[DRAFT LISTED FINALISED]

  def to_builder
    Jbuilder.new do |court_application|
      court_application.id id
      court_application.type application_type.to_builder
      court_application.applicationReceivedDate applicationReceivedDate.to_date
      court_application.applicationReference applicationReference
      court_application.applicant court_application_party.to_builder
      court_application.respondents array_builder(court_application_respondents)
      court_application.applicationOutcome court_application_outcome.to_builder if court_application_outcome.present?
      court_application.linkedCaseId linkedCaseId
      court_application.linkedSplitProsecutorCaseReference linkedSplitProsecutorCaseReference
      court_application.parentApplicationId parentApplicationId
      court_application.applicationParticulars applicationParticulars
      court_application.courtApplicationPayment court_application_payment.to_builder if court_application_payment.present?
      court_application.applicationDecisionSoughtByDate applicationDecisionSoughtByDate.to_date
      court_application.applicationStatus applicationStatus
      court_application.outOfTimeReasons outOfTimeReasons
      court_application.breachedOrder breachedOrder
      court_application.breachedOrderDate breachedOrderDate
      court_application.orderingCourt court_centre.to_builder if court_centre.present?
      court_application.judicialResults array_builder(judicial_results)
    end
  end
end
