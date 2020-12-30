# frozen_string_literal: true

class CourtApplicationCase < ApplicationRecord
  include BuilderMappable
  belongs_to :prosecution_case
  has_many :court_application_offences, dependent: :destroy

  validates :prosecution_case, presence: true

  def to_builder
    Jbuilder.new do |court_application_case|
      court_application_case.prosecutionCaseId prosecution_case.id
      court_application_case.prosecutionCaseReference prosecution_case.prosecution_case_identifier.caseURN
      court_application_case.offences array_builder(court_application_offences)
    end
  end
end
