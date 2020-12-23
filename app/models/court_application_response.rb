# frozen_string_literal: true

class CourtApplicationResponse < ApplicationRecord
  belongs_to :application_response_type, class_name: "CourtApplicationResponseType"

  validates :originatingHearingId, presence: true
  validates :applicationId, presence: true
  validates :applicationResponseDate, presence: true
  validates :application_response_type, presence: true

  def to_builder
    Jbuilder.new do |court_application_response|
      court_application_response.originatingHearingId originatingHearingId
      court_application_response.applicationId applicationId
      court_application_response.applicationResponseDate applicationResponseDate.to_date
      court_application_response.applicationResponseType application_response_type.to_builder
    end
  end
end
