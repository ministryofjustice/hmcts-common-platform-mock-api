# frozen_string_literal: true

class JudicialResultPrompt < ApplicationRecord
  has_many :user_groups
  belongs_to :judicial_result, optional: true

  validates :label, presence: true
  validates :isAvailableForCourtExtract, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |judicial_result_prompt|
      judicial_result_prompt.judicialResultPromptTypeId judicialResultPromptTypeId
      judicial_result_prompt.label label
      judicial_result_prompt.isAvailableForCourtExtract isAvailableForCourtExtract
      judicial_result_prompt.welshLabel welshLabel
      judicial_result_prompt.value value
      judicial_result_prompt.qualifier qualifier
      judicial_result_prompt.durationSequence durationSequence
      judicial_result_prompt.promptSequence promptSequence
      judicial_result_prompt.promptReference promptReference
      judicial_result_prompt.totalPenaltyPoints totalPenaltyPoints
      judicial_result_prompt.isFinancialImposition isFinancialImposition
      judicial_result_prompt.usergroups user_groups.map(&:group)
    end
  end
end
