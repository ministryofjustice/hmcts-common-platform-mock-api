# frozen_string_literal: true

class JudicialResultPromptDurationElement < ApplicationRecord
  validates :primaryDurationUnit, presence: true, if: -> { durationEndDate.blank? }
  validates :primaryDurationValue, presence: true, if: -> { durationEndDate.blank? }
  validates :durationStartDate, presence: true, if: -> { primaryDurationUnit.blank? }
  validates :durationEndDate, presence: true, if: -> { primaryDurationUnit.blank? }

  def to_builder
    Jbuilder.new do |judicial_result_prompt_duration_element|
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
