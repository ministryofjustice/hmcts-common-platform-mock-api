# frozen_string_literal: true

class MergedProsecutionCase < ApplicationRecord
  has_many :merged_prosecution_case_targets

  validates :prosecutionCaseReference, presence: true
  validates :merged_prosecution_case_targets, presence: true, length: { minimum: 2 }

  def to_builder
    Jbuilder.new do |merged_prosecution_case|
      merged_prosecution_case.prosecutionCaseReference prosecutionCaseReference
      merged_prosecution_case.mergedProsecutionCaseTargets Jbuilder.new.array! merged_prosecution_case_targets_builder
    end
  end

  private

  def merged_prosecution_case_targets_builder
    merged_prosecution_case_targets.map do |merged_prosecution_case_target|
      merged_prosecution_case_target.to_builder.attributes!
    end
  end
end
