# frozen_string_literal: true

class VerdictType < ApplicationRecord
  validates :category, presence: true
  validates :categoryType, presence: true

  DESCRIPTIONS_CATEGORIES_TYPES_DATA =
    { "Guilty" => %w[Guilty GUILTY],
      "Guilty but of alternative offence" => ["Guilty but of alternative offence", "GUILTY_BUT_OF_ALTERNATIVE_OFFENCE_BY_JURY_CONVICTED"],
      "Not Guilty" => ["Not Guilty", "Not Known"],
      "Guilty, by jury on judge's direction" => %w[Guilty GUILTY_BY_JURY_CONVICTED],
      "Not guilty, by jury on judge's direction" => ["Not Guilty", "Not Known"],
      "Jury unable to agree" => ["Not Guilty", "Not Known"],
      "Not guilty but guilty of lesser/alternative offence not charged namely" => ["Guilty but of lesser offence", "GUILTY_BUT_OF_LESSER_OFFENCE_BY_JURY_CONVICTED"],
      "Not guilty but guilty of lesser/alternative offence by judge's direction namely" => ["Guilty but of lesser offence", "GUILTY_CONVICTED"],
      "Not guilty under section 17 Criminal Justice Act (1967): prosecution offer no evidence " => ["Not Guilty", "Not Known"],
      "Defendant found under a disability" => ["Finding", "Not Known"],
      "Autrefois convict" => ["No verdict", "Not Known"],
      "Autrefois acquit" => ["No verdict", "Not Known"],
      "Not guilty by reason of insanity" => ["Not Guilty", "Not Known"],
      "Guilty by judge alone  (under DVC&V Act 2004)" => %w[Guilty GUILTY_CONVICTED],
      "Not guilty by judge alone (under DVC&V Act 2004)" => ["Not Guilty", "Not Known"],
      "Not guilty but guilty by Judge alone (under DVC&V Act 2004) of lesser/alternative offence not charged namely" => ["Guilty but of lesser offence", "Not Known"] }.freeze

  # The above verdict type data is not entirely accurate or complete but provides a basis for testing

  before_save do
    self.category = VerdictType::DESCRIPTIONS_CATEGORIES_TYPES_DATA[description][0]
    self.categoryType = VerdictType::DESCRIPTIONS_CATEGORIES_TYPES_DATA[description][1]
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
