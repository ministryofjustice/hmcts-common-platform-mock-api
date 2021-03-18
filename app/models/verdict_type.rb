# frozen_string_literal: true

class VerdictType < ApplicationRecord
  validates :category, presence: true
  validates :categoryType, presence: true

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
