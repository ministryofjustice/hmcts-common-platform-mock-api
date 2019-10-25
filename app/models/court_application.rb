# frozen_string_literal: true

class CourtApplication < ApplicationRecord
  belongs_to :application_type, class_name: 'CourtApplicationType'
  belongs_to :court_application_party
  belongs_to :court_application_outcome, optional: true
  belongs_to :court_application_payment, optional: true
  belongs_to :court_centre, optional: true
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
      court_application.respondents court_application_respondents_builder if court_application_respondents.present?
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
      court_application.judicialResults judicial_results_builder if judicial_results.present?
    end
  end

  private

  def court_application_respondents_builder
    court_application_respondents.map do |court_application_respondent|
      court_application_respondent.to_builder.attributes!
    end
  end

  def judicial_results_builder
    judicial_results.map do |judicial_result|
      judicial_result.to_builder.attributes!
    end
  end
end
