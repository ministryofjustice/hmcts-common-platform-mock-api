# frozen_string_literal: true

class LesserOrAlternativeOffence < ApplicationRecord
  validates :offenceDefinitionId, presence: true
  validates :offenceCode, presence: true
  validates :offenceTitle, presence: true
  validates :offenceLegislation, presence: true

  def to_builder
    Jbuilder.new do |lesser_or_alternative_offence|
      lesser_or_alternative_offence.offenceDefinitionId offenceDefinitionId
      lesser_or_alternative_offence.offenceCode offenceCode
      lesser_or_alternative_offence.offenceTitle offenceTitle
      lesser_or_alternative_offence.offenceLegislation offenceLegislation
    end
  end
end
