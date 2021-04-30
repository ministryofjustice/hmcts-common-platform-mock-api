class CourtApplicationCase < ApplicationRecord
  include BuilderMappable
  has_many :offences
  belongs_to :prosecution_case_identifier

  validates :prosecution_case_id, presence: true
  validates :prosecution_case_identifier, presence: true
  validates :is_sjp, inclusion: [true, false]
  validates :case_status, presence: true

  def to_builder(hearing: nil)
    Jbuilder.new do |court_application_case|
      court_application_case.prosecutionCaseId prosecution_case_id
      court_application_case.offences array_builder(offences, hearing: hearing)
      court_application_case.isSJP is_sjp
      court_application_case.prosecutionCaseIdentifier prosecution_case_identifier.to_builder
      court_application_case.caseStatus case_status
    end
  end
end
