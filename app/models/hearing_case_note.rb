# frozen_string_literal: true

class HearingCaseNote < ApplicationRecord
  belongs_to :court_clerk, class_name: 'DelegatedPowers'
  belongs_to :hearing
  has_many :prosecution_case_hearing_case_notes
  has_many :prosecution_cases, through: :prosecution_case_hearing_case_notes

  validates :hearing, presence: true
  validates :prosecution_cases, presence: true
  validates :noteDateTime, presence: true
  validates :noteType, presence: true, inclusion: %w[HMCTS LEGAL]
  validates :note, presence: true
  validates :court_clerk, presence: true

  def to_builder
    Jbuilder.new do |hearing_case_note|
      hearing_case_note.originatingHearingId hearing_id
      hearing_case_note.id id
      hearing_case_note.courtClerk court_clerk.to_builder
      hearing_case_note.prosecutionCases prosecution_cases.ids
      hearing_case_note.noteDateTime noteDateTime
      hearing_case_note.noteType noteType
      hearing_case_note.note note
    end
  end
end
