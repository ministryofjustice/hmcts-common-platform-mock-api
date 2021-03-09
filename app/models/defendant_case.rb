class DefendantCase < ApplicationRecord
  validates :defendant_id, presence: true
  validates :case_id, presence: true

  def to_builder
    Jbuilder.new do |defendant_case|
      defendant_case.defendantId defendant_id
      defendant_case.caseId case_id
      defendant_case.caseReference case_reference
    end
  end
end
