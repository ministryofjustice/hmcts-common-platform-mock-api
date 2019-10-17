class MergedProsecutionCaseTarget < ApplicationRecord

  validates :prosecutionCaseId, presence: true
  validates :prosecutionCaseReference, presence: true

  def to_builder
    Jbuilder.new do |merged_prosecution_case_target|
      merged_prosecution_case_target.prosecutionCaseId prosecutionCaseId
      merged_prosecution_case_target.prosecutionCaseReference prosecutionCaseReference
    end
  end

end
