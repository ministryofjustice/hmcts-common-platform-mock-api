# frozen_string_literal: true

class JudicialResultPromptDurationElement < ApplicationRecord
  validates :primaryDurationUnit, presence: true, if: -> { durationEndDate.blank? }
  validates :primaryDurationValue, presence: true, if: -> { durationEndDate.blank? }
  validates :durationStartDate, presence: true, if: -> { primaryDurationUnit.blank? }
  validates :durationEndDate, presence: true, if: -> { primaryDurationUnit.blank? }
  validates :primaryDurationValue, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }
  validates :secondaryDurationValue, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }
  validates :tertiaryDurationValue, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }

  def to_builder
    Jbuilder.new do |judicial_result_prompt_duration_element|
      judicial_result_prompt_duration_element.primaryLabel primaryLabel
      judicial_result_prompt_duration_element.secondaryDurationUnit secondaryDurationUnit
      judicial_result_prompt_duration_element.secondaryDurationValue secondaryDurationValue
      judicial_result_prompt_duration_element.tertiaryDurationUnit tertiaryDurationUnit
      judicial_result_prompt_duration_element.tertiaryDurationValue tertiaryDurationValue
      if primaryDurationUnit.present?
        judicial_result_prompt_duration_element.primaryDurationUnit primaryDurationUnit
        judicial_result_prompt_duration_element.primaryDurationValue primaryDurationValue
      else
        judicial_result_prompt_duration_element.durationStartDate durationStartDate
        judicial_result_prompt_duration_element.durationEndDate durationEndDate
      end
    end
  end
end
