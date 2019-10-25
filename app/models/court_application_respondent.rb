# frozen_string_literal: true

class CourtApplicationRespondent < ApplicationRecord
  belongs_to :party_details, class_name: 'CourtApplicationParty'
  belongs_to :application_response, class_name: 'CourtApplicationResponse', optional: true

  validates :party_details, presence: true

  def to_builder
    Jbuilder.new do |court_application_respondent|
      court_application_respondent.partyDetails party_details.to_builder
      court_application_respondent.applicationResponse application_response.to_builder if application_response.present?
    end
  end
end
