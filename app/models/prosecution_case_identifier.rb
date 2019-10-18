# frozen_string_literal: true

class ProsecutionCaseIdentifier < ApplicationRecord
  validates :prosecutionAuthorityId, presence: true
  validates :prosecutionAuthorityCode, presence: true

  def to_builder
    Jbuilder.new do |prosecution_case_identifier|
      prosecution_case_identifier.caseURN caseURN
      prosecution_case_identifier.prosecutionAuthorityId prosecutionAuthorityId
      prosecution_case_identifier.prosecutionAuthorityCode prosecutionAuthorityCode
    end
  end
end
