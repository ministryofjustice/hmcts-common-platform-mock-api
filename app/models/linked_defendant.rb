# frozen_string_literal: true

class LinkedDefendant < ApplicationRecord
  validates :prosecutionCaseId, presence: true
  validates :defendantId, presence: true

  def to_builder
    Jbuilder.new do |linked_defendant|
      linked_defendant.prosecutionCaseId prosecutionCaseId
      linked_defendant.defendantId defendantId
    end
  end
end
