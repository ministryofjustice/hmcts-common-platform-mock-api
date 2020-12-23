# frozen_string_literal: true

class CourtApplicationOutcome < ApplicationRecord
  belongs_to :application_outcome_type, class_name: "CourtApplicationOutcomeType"

  validates :originatingHearingId, presence: true
  validates :applicationId, presence: true
  validates :applicationOutcomeDate, presence: true
  validates :application_outcome_type, presence: true

  def to_builder
    Jbuilder.new do |court_application_outcome|
      court_application_outcome.originatingHearingId originatingHearingId
      court_application_outcome.applicationId applicationId
      court_application_outcome.applicationOutcomeDate applicationOutcomeDate.to_date
      court_application_outcome.applicationOutcomeType application_outcome_type.to_builder
    end
  end
end
