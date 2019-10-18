# frozen_string_literal: true

class DefendantAlias < ApplicationRecord
  TITLES = %w[MR MRS MISS MS].freeze

  validates :title, inclusion: TITLES

  def to_builder
    Jbuilder.new do |defendant_alias|
      defendant_alias.title title
      defendant_alias.firstName firstName
      defendant_alias.middleName middleName
      defendant_alias.lastName lastName
      defendant_alias.legalEntityName legalEntityName
    end
  end
end
