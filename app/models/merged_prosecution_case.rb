# frozen_string_literal: true

class MergedProsecutionCase < ApplicationRecord
  include BuilderMappable
  has_many :merged_prosecution_case_targets

  validates :prosecutionCaseReference, presence: true
  validates :merged_prosecution_case_targets, presence: true, length: { minimum: 2 }

  def to_builder
    Jbuilder.new do |merged_prosecution_case|
      merged_prosecution_case.prosecutionCaseReference prosecutionCaseReference
      merged_prosecution_case.mergedProsecutionCaseTargets array_builder(merged_prosecution_case_targets)
    end
  end
end
