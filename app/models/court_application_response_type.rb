# frozen_string_literal: true

class CourtApplicationResponseType < ApplicationRecord
  validates :sequence, numericality: { greater_than: 0 }
  validates :description, presence: true

  def to_builder
    Jbuilder.new do |court_application_response_type|
      court_application_response_type.id id
      court_application_response_type.sequence sequence
      court_application_response_type.description description
    end
  end
end
