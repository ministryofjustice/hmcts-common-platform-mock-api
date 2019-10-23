# frozen_string_literal: true

class CourtApplicationOutcomeType < ApplicationRecord
  validates :sequence, numericality: { greater_than: 0 }
  validates :description, presence: true

  def to_builder
    Jbuilder.new do |court_application_outcome_type|
      court_application_outcome_type.id id
      court_application_outcome_type.sequence sequence
      court_application_outcome_type.description description
    end
  end
end
