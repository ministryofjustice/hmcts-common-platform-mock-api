# frozen_string_literal: true

class CourtApplication < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  RESULT_CODES = [
    "G /STDEC", "RFSD", "WDRN", "D", "G / ROPENED", "RFSD", "WDRN"
  ].freeze

  belongs_to :court_application_party
  belongs_to :court_application_payment, optional: true
  belongs_to :court_application_type
  belongs_to :hearing, optional: true
  belongs_to :defendant, optional: true

  has_many :judicial_results, dependent: :destroy
  has_many :respondents, class_name: "CourtApplicationParty", dependent: :destroy

  # only used for application enpoint
  has_many :court_application_prosecution_case, dependent: :destroy
  has_many :prosecution_case, through: :court_application_prosecution_case

  # only used for application enpoint
  has_many :court_application_hearing, dependent: :destroy
  has_many :court_hearings, through: :court_application_hearing, source: :hearing

  accepts_nested_attributes_for :court_application_type

  validates :applicationReceivedDate, presence: true
  validates :court_application_party, presence: true
  validates :applicationStatus, presence: true, inclusion: %w[DRAFT LISTED FINALISED]
  validates :result_code, inclusion: { in: RESULT_CODES, allow_blank: true }

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
      court_application.respondents array_builder(respondents)
    end
  end

  def conclusion_payload
    application_conclusion = ApplicationConclusion.new(court_application: self).to_builder.attributes!

    { prosecutionConcluded: [application_conclusion] }.to_json
  end
end
