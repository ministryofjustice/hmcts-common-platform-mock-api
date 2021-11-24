# frozen_string_literal: true

class VerdictType < ApplicationRecord
  validates :category, presence: true
  validates :categoryType, presence: true

  CATEGORY_TYPES = { "GUILTY" => ["Found guilty", "Guilty"],
                     "GUILTY_BUT_OF_ALTERNATIVE_OFFENCE_BY_JURY_CONVICTED" => ["Guilty but of alternative offence", "Guilty but of alternative offence"],
                     "GUILTY_BUT_OF_LESSER_OFFENCE_BY_JURY_CONVICTED" => ["Guilty but of lesser offence", "Guilty but of lesser offence"],
                     "GUILTY_BY_JURY_CONVICTED" => ["Found guilty", "Guilty"],
                     "GUILTY_CONVICTED" => %w[Guilty Guilty] }.freeze

  before_save do
    self.description = VerdictType::CATEGORY_TYPES[categoryType][0]
    self.category = VerdictType::CATEGORY_TYPES[categoryType][1]
  end

  def to_builder
    Jbuilder.new do |verdict_type|
      verdict_type.id id
      verdict_type.sequence sequence
      verdict_type.description description
      verdict_type.category category
      verdict_type.categoryType categoryType
      verdict_type.cjsVerdictCode cjs_verdict_code
      verdict_type.verdictCode verdict_code
    end
  end
end
