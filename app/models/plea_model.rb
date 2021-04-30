class PleaModel < ApplicationRecord
  belongs_to :indicated_plea
  belongs_to :plea
  belongs_to :allocation_decision

  validates :offence_id, presence: true, if: -> { application_id.blank? }
  validates :application_id, presence: true, if: -> { offence_id.blank? }

  def to_builder
    Jbuilder.new do |plea_model|
      plea_model.prosecutionCaseId prosecution_case_id
      plea_model.defendantId defendant_id
      plea_model.offenceId offence_id
      plea_model.indicatedPlea indicated_plea.to_builder
      plea_model.plea plea.to_builder
      plea_model.allocationDecision allocation_decision.to_builder
      plea_model.applicationId application_id
    end
  end
end
