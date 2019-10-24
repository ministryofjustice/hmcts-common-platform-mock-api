# frozen_string_literal: true

class DefendantHearingYouthMarker < ApplicationRecord
  belongs_to :prosecution_case
  belongs_to :defendant
  belongs_to :marker

  validates :prosecution_case, presence: true
  validates :defendant, presence: true
  validates :hearing_id, presence: true
  validates :marker, presence: true

  def to_builder
    Jbuilder.new do |defendant_hearing_youth_marker|
      defendant_hearing_youth_marker.prosecutionCaseId prosecution_case_id
      defendant_hearing_youth_marker.defendantId defendant_id
      defendant_hearing_youth_marker.hearingId hearing_id
      defendant_hearing_youth_marker.marker marker.to_builder
    end
  end
end
